import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CustomPhysicalCardRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'https://your-api.com'; // Update to your real endpoint

  Future<void> createCustomPhysicalCard({
    required String userId,
    required String cardId,
    required String templateId,
    required String primaryColor,
    required String secondaryColor,
    required PlatformFile platformFile,
  }) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final fileName = platformFile.name;
    final bytes = platformFile.bytes;

    if (bytes == null) {
      throw Exception('File content is empty');
    }

    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: fileName,
      contentType: MediaType(
        lookupMimeType(fileName)!.split('/')[0],
        lookupMimeType(fileName)!.split('/')[1],
      ),
    );

    final formData = FormData.fromMap({
      "userId": userId,
      "cardId": cardId,
      "templateId": templateId,
      "primaryColor": primaryColor,
      "secondaryColor": secondaryColor,
      "finalDesign": multipartFile,
    });

    final response = await _dio.post('$baseUrl/api/custom-physical-card',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));

    if (response.statusCode != 201) {
      throw Exception("Upload failed");
    }
  }

  Future<void> updateCustomPhysicalCard({
    required String cardId,
    required String primaryColor,
    required String secondaryColor,
    required PlatformFile platformFile,
  }) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final fileName = platformFile.name;
    final bytes = platformFile.bytes;

    if (bytes == null) {
      throw Exception('File content is empty');
    }

    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: fileName,
      contentType: MediaType(
        lookupMimeType(fileName)!.split('/')[0],
        lookupMimeType(fileName)!.split('/')[1],
      ),
    );

    final formData = FormData.fromMap({
      "primaryColor": primaryColor,
      "secondaryColor": secondaryColor,
      "finalDesign": multipartFile,
    });

    final response = await _dio.put('$baseUrl/api/custom-physical-card$cardId',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));

    if (response.statusCode != 201) {
      throw Exception("Upload failed");
    }
  }
}
