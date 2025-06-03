import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  // Save a value
  static Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Get a value (returns null if not found)
  static Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a value
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all stored values
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}