import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String userAccessToken = "";
String clientAccessToken = "";

class SharedPref{
  static Future<Map<String, dynamic>> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString(key) ?? "");
  }
  static Future<String> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getString(key) ?? "";
  }
  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static read2(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var  stringValue = prefs.getString(key)??"";
    return stringValue;
  }

  static saveBool(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class SharedPrefKeys{
  static const loginValidationInfo = "loginInfo";
  static const loginRequestInfo = 'loginRequestInfo';
  static const checkedTerms = 'checkedTerms';
  static const enableBiometric = 'enableBiometric';
  static const bankList = 'bankList';
  static const userAccount = 'userAccount';
  static const userTransaction = 'userTransaction';
  static const airtimeVend = 'airtimeVend';
  static const createAccountUserID = 'clientId';
  static const createAccountUserPassword = 'clientPasskey';
}