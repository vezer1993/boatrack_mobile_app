import 'package:boatrack_mobile_app/services/push_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../main.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('_firebaseMessagingBackgroundHandler');

  PushNotifications.showBigTextNotification(title: message.data["title"], body: message.data["body"], fln: flutterLocalNotificationsPlugin);

}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotifications.showBigTextNotification(title: message.data["title"], body: message.data["body"], fln: flutterLocalNotificationsPlugin);
    });
    
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

}