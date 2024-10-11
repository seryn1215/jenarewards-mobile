import 'package:get_storage/get_storage.dart';

class StorageUtil {
  static final GetStorage _storage = GetStorage();

  // Save data to storage
  static Future<void> save(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  // Get data from storage
  static dynamic get(String key) {
    return _storage.read(key);
  }

  // Remove data from storage
  static Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  // Clear all data from storage
  static Future<void> clear() async {
    await _storage.erase();
  }
}
