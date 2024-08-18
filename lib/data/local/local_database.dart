import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static StorageRepository? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageRepository> getInstance() async {
    if (_storageUtil == null) {
      _storageUtil = StorageRepository._();
      await _storageUtil!._init();
    }
    return _storageUtil!;
  }

  StorageRepository._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> putString({required String key, required String value}) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setString(key, value);
  }

  Future<bool> putList(String key, List<String> value) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setStringList(key, value);
  }

  String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString(key) ?? defValue;
  }

  Future<bool> deleteString(String key) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.remove(key);
  }

  double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences!.getDouble(key) ?? defValue;
  }

  List<String> getList(String key, {List<String> defValue = const []}) {
    if (_preferences == null) return defValue;
    return _preferences!.getStringList(key) ?? defValue;
  }

  Future<bool> putDouble(String key, double value) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setDouble(key, value);
  }

  Future<bool> deleteDouble(String key) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.remove(key);
  }

  bool getBool(String key, {bool defValue = true}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  Future<bool> putBool(String key, bool value) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setBool(key, value);
  }

  Future<bool> deleteBool(String key) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.remove(key);
  }
}
