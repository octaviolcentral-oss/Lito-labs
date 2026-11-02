import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;

/// Local data encryption using AES-GCM.
/// Key should be derived from device biometrics or a user PIN in production.
class LocalEncryption {
  static final _key = enc.Key.fromUtf8('pulso_local_key_32bytes_long!!');
  static final _iv = enc.IV.fromLength(16);
  static final _encrypter = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.gcm));

  static Uint8List encrypt(String plainText) {
    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.bytes;
    } catch (e) {
      return Uint8List.fromList(utf8.encode(plainText));
    }
  }

  static String decrypt(Uint8List cipherText) {
    try {
      final encrypted = enc.Encrypted(cipherText);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      return utf8.decode(cipherText);
    }
  }
}
