import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/util.dart';

final shareCardQrRepositoryProvider = Provider((ref) => ShareCardQrRepository());

class ShareCardQrRepository {
  final Dio _dio = Dio(); // You can inject your base URL here

  Future<String> fetchQrCode(String cardId) async {
      final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
         
    try {
      final response = await _dio.get('${Endpoints.devBaseUrl}card/qr/$cardId', options: Options(
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        },
      ));

      if (response.statusCode == 200 && response.data != null) {
        return response.data['qrCode']; // Assuming API returns { "qrCode": "base64StringOrUrl" }
      } else {
        throw Exception('Failed to load QR code');
      }
    } catch (e) {
      throw Exception('Error fetching QR Code: $e');
    }
  }
}
