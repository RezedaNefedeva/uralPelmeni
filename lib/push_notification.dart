import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'dart:convert';
import 'api_key.dart';

class PushNotification {
  static Future<String> getAccessToken() async{
    final serviceAccountJson = {
      "type": ApiKey.type,
      "project_id": ApiKey.project_id,
      "private_key_id": ApiKey.private_key_id,
      "private_key": ApiKey.private_key,
      "client_email": ApiKey.client_email,
      "client_id": ApiKey.client_id,
      "auth_uri": ApiKey.auth_uri,
      "token_uri": ApiKey.token_uri,
      "auth_provider_x509_cert_url": ApiKey.auth_provider_x509_cert_url,
      "client_x509_cert_url": ApiKey.client_x509_cert_url,
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client
    );

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotification(String deviceToken, BuildContext context, String title, String body) async{
    final serverAccessTokenKey = await getAccessToken();
    print('Этот сраный аксесс токен - ${getAccessToken()}');
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/uralpelmen-99b41/messages:send';

    final Map<String, dynamic> message = {
      'message' : {
        'token' : deviceToken,
        'notification' : {
          'title' : title,
          'body' : body,
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String> {
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $serverAccessTokenKey'
      },
      body: jsonEncode(message),
    );

    if(response.statusCode == 200){
      print('Сообщение отправлено правильно');
    } else {
      print ('Нифига ничего не получилось!!!!!!');
    }
  }
}