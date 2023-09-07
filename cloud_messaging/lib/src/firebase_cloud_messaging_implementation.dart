import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart' as fcm;

import '../cloud_messaging.dart';
import '../convert_remote_message.dart';

/// The helper that contains useful method to retrieve a notification
/// payload.
class FirebaseCloudMessagingImplementation implements CloudMessaging {
  static final StreamController<RemoteMessage> _onMessageController =
      StreamController.broadcast();

  final fcm.FirebaseMessaging _messaging = fcm.FirebaseMessaging.instance;

  /// Constructs a new [FirebaseCloudMessagingImplementation].
  FirebaseCloudMessagingImplementation() {
    fcm.FirebaseMessaging.onMessage.listen((event) {
      final convertedMessage = convertRemoteMessage(event);
      _onMessageController.add(convertedMessage);
    });
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage == null) {
      return null;
    }
    return convertRemoteMessage(initialMessage);
  }

  @override
  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  @override
  Future<String?> getToken({String? vapidKey}) =>
      _messaging.getToken(vapidKey: vapidKey);

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == fcm.AuthorizationStatus.authorized;
  }

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<RemoteMessage> get onMessage => fcm.FirebaseMessaging.onMessage
      .map((event) => convertRemoteMessage(event));

  @override
  Stream<RemoteMessage> get onMessageOpenedApp =>
      fcm.FirebaseMessaging.onMessageOpenedApp
          .map((event) => convertRemoteMessage(event));

  @override
  Future<void> unsubscribeFromTopic(String topic) =>
      _messaging.unsubscribeFromTopic(topic);
}
