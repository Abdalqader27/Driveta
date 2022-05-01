// import 'dart:convert';
//
// import 'package:driver/common/values/keys.dart';
// import 'package:driver/features/auth/infrastructure/models/user_account.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesUser {
//   static Future<UserAccount> getUser() async {
//     final sPrefs = await SharedPreferences.getInstance();
//     final string = sPrefs.getString(AppKeys.kUserBox)!;
//
//     Map<String, dynamic> d = json.decode(string);
//     UserAccount user = UserAccount.fromJson(d);
//     return user;
//   }
//
//   static Future<void> setUser(UserAccount value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(AppKeys.kUserBox, jsonEncode(value.toJson()));
//   }
//
//   static remove() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(AppKeys.kUserBox);
//   }
// }
