import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:submission_may11/pages/welcome_page.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool permission;

  @override
  void initState() {
   _setupForegroundNotifications();
    super.initState();
  }
  void _setupForegroundNotifications() async {
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      permission = true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
      permission = true;
    } else {
      debugPrint('User declined or has not accepted permission');
      permission = false;
    }
    if (permission) {
      FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) {
          log('Home: A new onMessage event was published');
          log('Got a message while in the foreground');
          log('Message data: ${message.toMap().toString()}');

          RemoteNotification? notifcation = message.notification;
          debugPrint(message.toMap().toString());
          if (notifcation != null) {
            flutterLocalNotificationsPlugin.show(
                notifcation.hashCode,
                notifcation.title,
                notifcation.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    icon: 'launcher_icon',
                    color: const Color(0XFF000749),
                    playSound: true,
                  ),
                ),
                payload: jsonEncode(message.data));
          }
        },
      );
      FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) {
          debugPrint('A new onMessageOpenedApp event was published');
          debugPrint(message.toMap().toString());
         // _handleAction(message.data);
          //  _goToResultScreen();
        },
      );
      FirebaseMessaging.instance.getInitialMessage().then((message){
        debugPrint('aaaaaaaaaaaaaaaaaaaaa');
        if(message != null) {
          debugPrint('A new onMessageOpenedApp event was published');
          debugPrint(message!.toMap().toString());
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if(notification !=null && android !=null) {
            //   _handleAction(message.data);
          }
        }
      });
    }
  }

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showNotification(title: 'Notification Received',body: 'VivaTech R&D',);
          },
          child: const Text('Show Notification'),
        ),
        ElevatedButton(
          onPressed: () async {
            FirebaseAuth _auth = FirebaseAuth.instance;
            await _auth.signOut().whenComplete(() => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  WelcomePage()),
            ) ,);
          },
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}
