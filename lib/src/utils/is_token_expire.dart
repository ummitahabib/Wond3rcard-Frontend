import 'dart:convert';

/// Function to check if JWT token is expired
bool isTokenExpired(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return true; // Invalid token

    final payload = jsonDecode(utf8.decode(base64Url.decode(parts[1])));
    final exp = payload['exp'] as int;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return now > exp;
  } catch (e) {
    return true; // If decoding fails, assume token is expired
  }
}
