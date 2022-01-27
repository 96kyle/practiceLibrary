import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification extends StatefulWidget {
  const FirebaseNotification({Key? key}) : super(key: key);

  @override
  _FirebaseNotificationState createState() => _FirebaseNotificationState();
}

class _FirebaseNotificationState extends State<FirebaseNotification> {
  RemoteMessage? message = RemoteMessage();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print(token);
  // }

  Future<void> initialize() async {
    await Firebase.initializeApp();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage rm) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage rm) {
      setState(() {
        message = rm;
      });
    });

    // FirebaseMessaging.onBackgroundMessage((message) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림 테스트'),
      ),
      body: Container(
        child: Text('${message?.notification?.title ?? 'title'}'),
      ),
    );
  }
}
