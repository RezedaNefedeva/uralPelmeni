import 'dart:convert';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationServices {
  static pushNotification() async{
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if(androidPlugin != null){
      await androidPlugin.createNotificationChannel(channel);
    }

  }



    static Future initialize(FlutterLocalNotificationsPlugin flutterNotificationPlugin)async{
        var androidInitialize = const AndroidInitializationSettings('push_logo');
        DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings();

        var initializationSettings = InitializationSettings(
            android: androidInitialize,
        );

        await flutterNotificationPlugin.initialize(initializationSettings);

    }

    static Future showNotification({
        var id = 0,
        required String title,
        required String body,
        var payload,
        required FlutterLocalNotificationsPlugin flutterNotificationPlugin,
        required String token
    }) async{
       AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
           'pushnotification',
           'chanel_name',
           playSound: true,
           importance: Importance.max,
           priority: Priority.high,
       );

       try {
         await http.post(
           Uri.parse('https://fcm.googleapis.com/v1/projects/myproject-uralpelmen-99b41/messages:send'),
           headers: <String, String>{
             'Content-Type': 'application/json',
             'Authorization': 'Bearer $token',
           },
           body: jsonEncode(
             <String, dynamic>{
               'notification': <String, dynamic>{
                 'body': body,
                 'title': title
               },
               'priority': 'high',
               'data': <String, dynamic>{
                 'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                 'id': '1',
                 'status': 'done'
               },
               "to": token,
             },
           ),
         );
       } catch (e) {
         print("error push notification");
       }
    }

}
