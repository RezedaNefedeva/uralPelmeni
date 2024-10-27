import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uralpelmen/features/profile/widgets/shared_data.dart';

import 'firebase_options.dart';
import 'flutter_cart.dart';
import 'local_services.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedData.initName();

  getToken();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
                channelDescription: channel.description,
                icon: 'push_logo'
              // other properties...
            ),
          ));
    }
  });

  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);

  runApp(MaterialApp(
    theme: theme,
    initialRoute: '/',
    routes: routes,
  ));

}


void getToken() async{
  await FirebaseMessaging.instance.getToken().then(
          (token) {
        saveToken(token!);
        print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print('Токен - $token');
      }
  );
}

void saveToken(String token) async{
  await FirebaseFirestore.instance.collection('userTokens').doc(SharedData.userPhone).set({
    'token' : token,
  });

}
