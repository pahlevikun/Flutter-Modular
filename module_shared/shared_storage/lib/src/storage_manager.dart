import 'package:shared_utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  final SharedPreferences _preferences;

  StorageManager(this._preferences);

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    Logger.debug(
        '(TRACE READ) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveToDisk<T>(String key, T content) {
    Logger.debug(
        '(TRACE WRITE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  void removeFromDisk(String key) {
    _preferences.remove(key);
  }
}
