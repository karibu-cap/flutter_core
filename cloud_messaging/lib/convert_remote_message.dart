import 'package:firebase_messaging/firebase_messaging.dart' as fcm;
import '../cloud_messaging.dart';

/// Converts firebase remote message to our generic remote message.
RemoteMessage convertRemoteMessage(fcm.RemoteMessage fcmRemoteMessage) {
  return RemoteMessage(
      senderId: fcmRemoteMessage.senderId,
      category: fcmRemoteMessage.category,
      collapseKey: fcmRemoteMessage.collapseKey,
      contentAvailable: fcmRemoteMessage.contentAvailable,
      data: fcmRemoteMessage.data,
      from: fcmRemoteMessage.from,
      messageId: fcmRemoteMessage.messageId,
      messageType: fcmRemoteMessage.messageType,
      mutableContent: fcmRemoteMessage.mutableContent,
      sentTime: fcmRemoteMessage.sentTime,
      threadId: fcmRemoteMessage.threadId,
      ttl: fcmRemoteMessage.ttl,
      notification: fcmRemoteMessage.notification);
}
