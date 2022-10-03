import 'package:shared_preferences/shared_preferences.dart';

class LOCAL_STORAGE {

  static Future<bool> saveValue(String key, String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

  static Future<String?> getValue(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> removeValue (String key) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    return true;
  }

}