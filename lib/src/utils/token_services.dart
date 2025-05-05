import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class TokenService {
  String generateFCMToken() {
    var uuid = Uuid().v4();
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var rawToken = '$uuid-$timestamp';
    var bytes = utf8.encode(rawToken);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }
}
