import 'package:dio/dio.dart';
import 'package:wond3rcard/src/physical_card/data/model/physical_card_template_model.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/util.dart';

class TemplateRepository {
  final Dio _dio;

  TemplateRepository(this._dio);

  Future<List<CardTemplateModel>> getTemplates() async {
    try {
          final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
      final response = await _dio
          .get('https://wond3rcard-backend.onrender.com/api/phy-cards/templates', 
          
          options: Options(
                headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        },
          )); 
      if (response.statusCode == 200) {
        final data = response.data['payload'] as List;
        return data.map((json) => CardTemplateModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch templates');
      }
    } catch (e) {
      throw Exception('Template fetch error: $e');
    }
  }
}
