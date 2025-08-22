import 'dart:convert';

import '../../../core/services/data/session_manager.dart';


class UserStorage {
  // static const _kUserTokenKey = StorageKeys.token;

  UserStorage();

  // Save user data to SharedPreferences
  Future<void> saveUser(dynamic user) async {
    final userJson = jsonEncode(user.toJson());
    SessionManager.instance.usersData = user.toJson();
  }

  Future<dynamic?> getUser() async {
    final userJson = SessionManager.instance.usersData;
    if (userJson != null) {
      return userJson;
    }
    return null; // Return null if user data doesn't exist
  }

  // Clear user data from SharedPreferences
  Future<void> clearUser() async {
    SessionManager.instance.usersData = {};
  }

  Future<void> saveUserToken(String token) async {
    SessionManager.instance.authToken = token;

  }
}
