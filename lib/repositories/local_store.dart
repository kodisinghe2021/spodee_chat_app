import 'package:get_storage/get_storage.dart';

class LocalStore {
  LocalStore._intenal();
  static final LocalStore _instance = LocalStore._intenal();
  factory LocalStore() => _instance;

  final GetStorage _getStorage = GetStorage();

  Future<bool> isAvailable(String key) async {
   try {
      return _getStorage.hasData(key);
   } catch (e) {
    return false;
   }
  }

  Future<String?> getData(String key) async {
   try {
      bool isAvailable = await _getStorage.hasData(key);

    if (isAvailable) {
      String value = _getStorage.read(key).toString();
      return value;
    } else {
      return null;
    }
   } catch (e) {
    return null;
   }
  }

  Future<void> insertData(String key, String value) async {
    try {
      await _getStorage.write(key, value);
    } catch (e) {
      return;
    }
  }

  Future<void> clearAll() async {
    try {
      await _getStorage.erase();
    } catch (e) {
      return;
    }
  }


}
