import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static const String _tokenKey = 'TOKEN';
  static const String _email = 'Email';
  static const String _name = 'Name';
  static const String _isFirstTimeOpen = 'isFirstTimeOpen';
  static String? myToken;
  static String? myEmail;
  static String? myName;
  static bool? onboarding = true;

  static Future<void> setOnboard(bool isFirstTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_isFirstTimeOpen, isFirstTime);
  }

  static Future<void> getOnboard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    onboarding = await sharedPreferences.getBool(_isFirstTimeOpen) ?? true;
  }

  static Future<void> saveToken(String tokenValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, tokenValue);
    myToken = tokenValue;
  }

  static Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    myToken = await sharedPreferences.getString(_tokenKey);
    return myToken;
  }

  static bool isLoggedIn() {
    return myToken != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // TODO ENABLE these before publish
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_email);
    await sharedPreferences.remove(_name);
    myToken = null;
    myEmail = null;
    myName = null;
    // await sharedPreferences.clear();
  }

  static Future<void> setUserDataCache(String email, name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_email, email);
    await sharedPreferences.setString(_name, name);
  }

  static Future<void> getUserDataCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    myEmail = await sharedPreferences.getString(_email);
    myName = await sharedPreferences.getString(_name);
  }
}
