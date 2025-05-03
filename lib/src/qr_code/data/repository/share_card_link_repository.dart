import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/utils/util.dart';



final shareCardLinkRepositoryProvider = Provider<ShareCardLinkRepository>((ref) {
  return ShareCardLinkRepository(Dio());
});

class ShareCardLinkRepository {
  final Dio dio;

  ShareCardLinkRepository(this.dio);

  Future<String> fetchShareableLink(String cardId) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      final response = await dio.get(
        '${Endpoints.baseUrl}card/share/$cardId',
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final payload = response.data['payload'];
        if (payload is Map<String, dynamic> &&
            payload['qrShareableLink'] != null) {
          return payload['qrShareableLink'] as String;
        } else {
          throw Exception('Invalid payload structure');
        }
      } else {
        throw Exception('Failed to fetch shareable link');
      }
    } catch (e) {
      throw Exception('Error fetching shareable link: $e');
    }
  }
}
