import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class StorageUtil {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

    // get string
  static String? getString({required String key}) {
    if (key == SessionString.accessTokenString) {
      return _preferences?.getString(key) ?? '';
    }

    if (key == SessionString.refreshTokenString) {
      return _preferences?.getString(key) ?? '';
    }
    if (_preferences == null) return null;
    return _preferences?.getString(key)  ;
  }


  static Future<bool> putString({required String key, required String value}) async {
    if (_preferences == null) await init();
    return await _preferences!.setString(key, value);
  }

  static Future<bool> removeKey({required String key}) async {
    if (_preferences == null) await init();
    return await _preferences!.remove(key);
  }

  static Future<bool> clearAll() async {
    if (_preferences == null) await init();
    return await _preferences!.clear();
  }
}
