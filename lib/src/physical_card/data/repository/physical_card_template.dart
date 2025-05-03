import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_template_model.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';

class CardTemplateRepository {
  final Dio dio;

  CardTemplateRepository(this.dio);

  Future<CardTemplateModel> createTemplate({
    required String name,
    required String priceNaira,
    required String priceUsd,
    required PlatformFile file,
  }) async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    MultipartFile multipartFile;
    String mimeType = lookupMimeType(file.name) ?? 'image/svg+xml';

    if (kIsWeb) {
      final Uint8List? fileBytes = file.bytes;
      if (fileBytes == null) {
        throw Exception("File bytes are null on Web.");
      }

      multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.name,
        contentType: MediaType.parse(mimeType),
      );
    } else {
      final filePath = file.path;
      if (filePath == null) {
        throw Exception("File path is null on Mobile.");
      }

      multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: file.name,
        contentType: MediaType.parse(mimeType),
      );
    }

    final formData = FormData.fromMap({
      'name': name,
      'priceNaira': priceNaira,
      'priceUsd': priceUsd,
      'svg': multipartFile,
    });

    final response = await dio.post(
      'phy-cards/create-template',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return CardTemplateModel.fromJson(response.data['payload']);
  }

  Future<List<CardTemplateModel>> getAllTemplates() async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.get(
      'phy-cards/templates',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final List<dynamic> data = response.data['payload'];
    return data.map((json) => CardTemplateModel.fromJson(json)).toList();
  }

  Future<CardTemplateModel> getTemplateById(String id) async {
    final response = await dio.get('phy-cards/template/:$id');
    final data = response.data['payload'];
    return CardTemplateModel.fromJson(data);
  }

  Future<CardTemplateModel> updateTemplate({
    required String templateId,
    required String priceNaira,
    required String priceUsd,
    PlatformFile? svgFile,
  }) async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    MultipartFile? multipartSvg;
    if (svgFile != null) {
      final mimeType = lookupMimeType(svgFile.name) ?? 'image/svg+xml';

      multipartSvg = kIsWeb
          ? MultipartFile.fromBytes(svgFile.bytes!,
              filename: svgFile.name, contentType: MediaType.parse(mimeType))
          : await MultipartFile.fromFile(svgFile.path!,
              filename: svgFile.name, contentType: MediaType.parse(mimeType));
    }

    final formData = FormData.fromMap({
      'priceNaira': priceNaira,
      'priceUsd': priceUsd,
      if (multipartSvg != null) 'svg': multipartSvg,
    });

    final response = await dio.patch(
      'phy-cards/update-card-template/$templateId',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return CardTemplateModel.fromJson(response.data['payload']);
  }

  Future<String> deleteCardTemplate({required String templateId}) async {
    final token = StorageUtil.getString(key: SessionString.accessTokenString);

    final response = await dio.delete(
      'phy-cards/template/$templateId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response.data['message'];
  }
}
