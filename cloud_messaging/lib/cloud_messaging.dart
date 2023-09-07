import 'package:firebase_messaging/firebase_messaging.dart';

import 'src/fake_cloud_messaging_implementation.dart';
import 'src/firebase_cloud_messaging_implementation.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fcm;

enum CloudMessagingType { firebase, fake }

typedef FcmBackgroundMessageHandler = Future<void> Function(
    fcm.RemoteMessage message);

/// The helper that contains useful method to retrieve a notification
/// payload.
abstract class CloudMessaging {
  /// Constructs a new [CloudMessaging].
  factory CloudMessaging({required CloudMessagingType type}) {
    switch (type) {
      case CloudMessagingType.firebase:
        return FirebaseCloudMessagingImplementation();
      default:
        return FakeCloudMessagingImplementation();
    }
  }

  /// If the application has been opened from a terminated state via a [RemoteMessage]
  /// (containing a [Notification]), it will be returned, otherwise it will be `null`.
  ///
  /// Once the [RemoteMessage] has been consumed, it will be removed and further
  /// calls to [getInitialMessage] will be `null`.
  ///
  /// This should be used to determine whether specific notification interaction
  /// should open the app with a specific purpose (e.g. opening a chat message,
  /// specific screen etc).
  Future<RemoteMessage?> getInitialMessage();

  /// Fires when a new token is generated.
  Stream<String>? get onTokenRefresh;

  /// Returns a Stream that receives a message each time a notification
  /// is created with the application in the foreground.
  Stream<RemoteMessage>? get onMessage;

  /// Returns a Stream that receives a message each time a notification
  /// is created when the application is opened by notification.
  Stream<RemoteMessage>? get onMessageOpenedApp;

  /// Returns the default token of this device.
  ///
  /// On web, provide the validKey for the initial hand shake.
  Future<String?> getToken({String? vapidKey});

  /// Returns true if the user granted permissions for notifications.
  Future<bool> requestPermission();

  /// Subscribe to topic in background.
  ///
  /// [topic] must match the following regular expression:
  /// `[a-zA-Z0-9-_.~%]{1,900}`.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes from topic in background.
  Future<void> unsubscribeFromTopic(String topic);

  /// Sets a message handler function which is called when the app is in the
  /// background or terminated.
  static void onFcmBackgroundMessage(
      FcmBackgroundMessageHandler backgroundMessageHandler) {
    fcm.FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }
}

/// A class representing a message sent from Firebase Cloud Messaging.
class RemoteMessage {
  const RemoteMessage(
      {this.senderId,
      this.category,
      this.collapseKey,
      this.contentAvailable = false,
      this.data = const <String, dynamic>{},
      this.from,
      this.messageId,
      this.messageType,
      this.mutableContent = false,
      this.sentTime,
      this.threadId,
      this.notification,
      this.ttl});

  /// The ID of the upstream sender location.
  final String? senderId;

  /// The iOS category this notification is assigned to.
  final String? category;

  /// The collapse key a message was sent with. Used to override existing messages with the same key.
  final String? collapseKey;

  /// Whether the iOS APNs message was configured as a background update notification.
  final bool contentAvailable;

  /// Any additional data sent with the message.
  final Map<String, dynamic> data;

  /// The topic name or message identifier.
  final String? from;

  /// A unique ID assigned to every message.
  final String? messageId;

  /// The message type of the message.
  final String? messageType;

  /// Whether the iOS APNs `mutable-content` property on the message was set
  /// allowing the app to modify the notification via app extensions.
  final bool mutableContent;

  /// The time the message was sent, represented as a [DateTime].
  final DateTime? sentTime;

  /// An iOS app specific identifier used for notification grouping.
  final String? threadId;

  /// The time to live for the message in seconds.
  final int? ttl;

  /// Additional Notification data sent with the message.
  final RemoteNotification? notification;
}
