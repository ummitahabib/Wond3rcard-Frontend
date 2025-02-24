import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class TokenService {
  // Generate a unique token using a combination of UUID and SHA256 hash
  String generateFCMToken() {
    // Generate a random UUID
    var uuid = Uuid().v4();

    // Get current timestamp
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Combine UUID and timestamp
    var rawToken = '$uuid-$timestamp';

    // Generate a SHA256 hash of the combined string
    var bytes = utf8.encode(rawToken);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }
}
