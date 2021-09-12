import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> saveClockIn(bool clockIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('clocked_in', clockIn);
  }

  static getClockIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('clocked_in');
    // return prefs.get('clocked_in');
  }

  static Future<bool> setStaffId(String staffId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('staffId', staffId);
  }

  static Future<dynamic> getStaffId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('staffId'));
  }

  static Future<bool> setUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userName', username);
  }

  static Future<dynamic> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('userName'));
  }

  static Future<bool> setPhoneNumber(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('phoneNumber', username);
  }

  static Future<dynamic> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('phoneNumber'));
  }

  // static Future<bool> setUserData(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('userData', id);
  // }

  // static Future<String> getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return Future(() => prefs.getString('userData'));
  // }

  // static Future<bool> setUserID(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('userId', id);
  // }

  // static Future<String> getUserID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return Future(() => prefs.getString('userId'));
  // }

  // static Future<bool> setUserPhone(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('phone', id);
  // }

  // static Future<String> getUserPhone() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return Future(() => prefs.getString('phone'));
  // }

  // static Future<bool> removeUserID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.remove('userId');
  // }

  // static Future<bool> setUserName(String name) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('userName', name);
  // }

  // static Future<String> getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return Future(() => prefs.getString('userName'));
  // }

  // static Future<bool> removeUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.remove('userName');
  // }

  // static Future<bool> setUserPhoto(String url) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('photoUrl', url);
  // }

  // static Future<bool> removeUserPhoto() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.remove('photoUrl');
  // }

  // static Future<String> getUserPhoto() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return Future(() => prefs.getString('photoUrl'));
  // }

  // save position info on storage
  static Future<bool> savePositionInfo(Map<String, dynamic> position) async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString('position', json.encode(position));
  }

  // get position info on storage

  static Future<Map<String, dynamic>?> getPositionInfo() async {
    final _prefs = await SharedPreferences.getInstance();
    final _position = _prefs.getString('position');
    try {
      return json.decode(_position!) as Map<String, dynamic>;
    } catch (err) {
      return null;
    }
  }

  // // static Future<bool> deleteLocation() async {
  // //   final _prefs = await SharedPreferences.getInstance();
  // //   return await _prefs.remove('position');
  // // }
}
