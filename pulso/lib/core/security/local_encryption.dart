import 'dart:convert';
import 'dart:typed_data';

/// Foundation for local data encryption.
/// In production, use flutter_secure_storage or encrypt package with a key
/// derived from device biometrics or a user PIN.
class LocalEncryption {
  /// Placeholder: returns data as-is.
  /// Replace with real encryption (AES-GCM) when key management is ready.
  static Uint8List encrypt(String plainText, String key) {
    // TODO: Implement AES-GCM encryption
    return Uint8List.fromList(utf8.encode(plainText));
  }

  /// Placeholder: returns data as-is.
  static String decrypt(Uint8List cipherText, String key) {
    // TODO: Implement AES-GCM decryption
    return utf8.decode(cipherText);
  }
}
