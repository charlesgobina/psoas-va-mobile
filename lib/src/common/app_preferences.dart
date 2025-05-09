import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // Singleton instance
  static final AppPreferences _instance = AppPreferences._internal();

  // Factory constructor to return the singleton instance
  factory AppPreferences() {
    return _instance;
  }

  // Private constructor for singleton
  AppPreferences._internal();

  // SharedPreferences instance
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // set notify me preference for an apartment
  Future<void> setNotifyMe(String address, bool value) async {
    await _prefs.setBool(address, value);
  }

  // get notify me preference for an apartment
  bool getNotifyMe(String address) {
    return _prefs.getBool(address) ?? false;
  }

   // Clear all preferences
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}



