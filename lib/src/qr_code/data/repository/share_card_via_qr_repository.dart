import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/util.dart';

final shareCardQrRepositoryProvider = Provider<ShareCardQrRepository>((ref) {
  return ShareCardQrRepository(Dio());
});

class ShareCardQrRepository {
  final Dio dio;

  ShareCardQrRepository(this.dio);

  // Future<String> fetchQrCode(String cardId) async {
  // final String? authToken =
  //     StorageUtil.getString(key: SessionString.accessTokenString);

  //   try {
  //     final response = await dio.post(
  //       '${Endpoints.devBaseUrl}card/qr/$cardId',
  // options: Options(
  //   headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $authToken',
  //   },
  // ),
  //     );

  //     if (response.statusCode == 200 && response.data != null) {
  //       final payload = response.data['payload'];
  //       if (payload is Map<String, dynamic> &&
  //           payload['qrShareableLink'] != null) {
  //         return payload['qrShareableLink'] as String;
  //       } else {
  //         throw Exception('Invalid payload structure');
  //       }
  //     } else {
  //       throw Exception('Failed to load QR code');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching QR Code: $e');
  //   }
  // }

  Future<String> fetchQrCode(String cardId) async {
    final String url =
        'https://wond3rcard-backend.onrender.com/api/cards/qr/$cardId';

    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data['status'] == 'success' &&
          response.data['payload']?['qrShareableLink'] != null) {
        return response.data['payload']['qrShareableLink'];
      } else {
        throw Exception(
            'Failed to generate QR link: ${response.data['message']}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
  // final response = await dio.post(
  //   '${Endpoints.devBaseUrl}card/qr/$cardId',
  // options: Options(
  //   headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $authToken',
  //   },
  // ),
  // );
  // if (response.statusCode == 200 && response.data['status'] == 'success') {
  //   return response.data['payload']['qrShareableLink'];
  // } else {
  //   throw Exception('Failed to generate QR link');
  // }
}
