import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> setUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userType', userType);
  }

  static Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('userType'));
  }

  static Future<bool> setUserData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userData', id);
  }

  static Future<String?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('userData'));
  }

  static Future<bool> setUserID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', id);
  }

  static Future<String?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('userId'));
  }

  static Future<bool> setUserPhone(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('phone', id);
  }

  static Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('phone'));
  }

  static Future<bool> removeUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('userId');
  }

  static Future<bool> setUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userName', name);
  }

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('userName'));
  }

  static Future<bool> removeUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('userName');
  }

  static Future<bool> setUserPhoto(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('photoUrl', url);
  }

  static Future<bool> removeUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('photoUrl');
  }

  static Future<String?> getUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('photoUrl'));
  }

  // save position info on storage
  static Future<bool> savePositionInfo(Map<String, dynamic> position) async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString('position', json.encode(position));
  }

  // get position info on storage
  static Future<Map<String, dynamic>?> getPositionInfo() async {
    final _prefs = await SharedPreferences.getInstance();
    final String? _position = _prefs.getString('position');
    try {
      return json.decode(_position!) as Map<String, dynamic>;
    } catch (err) {
      return null;
    }
  }

  static Future<bool> deleteLocation() async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.remove('position');
  }
}
