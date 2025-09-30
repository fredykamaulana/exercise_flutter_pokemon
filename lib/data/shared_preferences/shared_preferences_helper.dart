import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences prefs;

  SharedPreferencesHelper({required this.prefs});

  static const username = 'userToken';

  Future<void> saveToken(String token) async {
    final status = await prefs.setString(username, token);

    if (status && kDebugMode) {
      print('Token saved successfully');
    } else {
      print('Failed to save token');
    }
    // await prefs.setInt('userAge', 30);
    // await prefs.setBool('isLoggedIn', true);
    // await prefs.setStringList('favoriteColors', ['red', 'blue', 'green']);
  }

  Future<String> readToken() async {
    final userToken = prefs.getString(username) ?? ''; // Default value if null

    return userToken;
  }

  // This class was removed in recent edits.
}
