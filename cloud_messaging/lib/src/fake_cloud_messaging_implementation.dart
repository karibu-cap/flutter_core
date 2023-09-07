import '../cloud_messaging.dart';

class FakeCloudMessagingImplementation implements CloudMessaging {
  @override
  Future<RemoteMessage?> getInitialMessage() async => null;

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}

  @override
  Stream<RemoteMessage>? get onMessage => null;

  @override
  Stream<String>? get onTokenRefresh => null;

  @override
  Future<String?> getToken({String? vapidKey}) => Future.value('fake-token');

  @override
  Future<bool> requestPermission() => Future.value(true);

  @override
  Stream<RemoteMessage>? get onMessageOpenedApp => null;
}
