
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData extends StatefulWidget {
  const SharedData({super.key});

  static const nameKey = 'name';
  static const phoneKey = 'phone';
  static const emailKey = 'email';
  static const adressListKey = 'adress';
  static const showADKey = 'showAD';

  static String userName = '';
  static String userPhone = '';
  static String userEmail = '';
  static String adressList = '';
  static String showAlertDialog = '';


  static Future setName(String name) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(nameKey, name);
  }

  static Future <String> getName() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey) ?? '';
  }

  static Future setPhone(String phone) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(phoneKey, phone);
  }

  static Future <String> getPhone() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneKey) ?? '';
  }

  static Future setEmail(String email) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(emailKey, email);
  }

  static Future <String> getEmail() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey) ?? '';
  }

  static Future setAdressList(String adress) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(adressListKey, adress);
  }

  static Future <String> getAdressList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(adressListKey) ?? '';
  }

  static Future setShowAD(String showAD) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(showADKey, showAD);
  }

  static Future <String> getShowAD() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(showADKey) ?? '';
  }

  static Future initName() async {
    userName = await getName();
    userPhone = await getPhone();
    userEmail = await getEmail();
    adressList = await getAdressList();
    showAlertDialog = await getShowAD();
  }

  static Future exitUser() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(nameKey);
    prefs.remove(phoneKey);
    prefs.remove(emailKey);
    prefs.remove(adressListKey);
    prefs.remove(showADKey);
  }

  @override
  State<SharedData> createState() => _SharedDataState();
}


class _SharedDataState extends State<SharedData> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
