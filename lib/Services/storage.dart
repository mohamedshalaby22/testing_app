import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const nameKey = 'NAME';
  static String myName = '';
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  static writeSecureName(String value) async {
    await secureStorage.write(key: nameKey, value: value);
  }

  static readSecureName() async {
    return myName = await secureStorage.read(key: nameKey) ?? 'Not Found';
  }
}
