import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final _storage = FlutterSecureStorage();

  
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  
  static Future<void> removeToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  static Future<void> saveLoginState(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn); 
}

  
  static Future<bool?> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn');
  }

  
  static Future<void> saveSessions(List<Map<String, dynamic>> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    String sessionsJson = jsonEncode(sessions);
    await prefs.setString('sessions', sessionsJson);
  }

  
  static Future<List<Map<String, dynamic>>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedSessions = prefs.getString('sessions');

    if (storedSessions != null) {
      List<dynamic> sessionList = jsonDecode(storedSessions);
      return sessionList.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  
  static Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); 
    await removeToken(); 
  }
}
