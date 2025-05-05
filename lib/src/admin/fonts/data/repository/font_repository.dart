import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/fonts/data/model/font_model.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';

final fontRepositoryProvider =
    Provider((ref) => FontRepository(client: ref.watch(apiProvider)));

class FontRepository {
  final ApiClient _client;

  FontRepository({required ApiClient client}) : _client = client;

  Future<RequestRes> uploadFont(Font font) async {
    try {
      final formData = FormData.fromMap(font.toMap());
      final response = await _client
          .post(getUrl(Endpoints.uploadFonts), data: formData)
          .then((value) => value);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAllFonts() async {
    try {
      final response = await _client.get(
        getUrl(Endpoints.getSocialMedia),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
      final fontResponse = Font.fromJson(response);

      return RequestRes(response: fontResponse);
    } catch (e) {
      print(e);
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateFont(Font font) async {
    try {
      final formData = FormData.fromMap(font.toMap());
      final response = await _client
          .post(getUrl(Endpoints.updateFonts), data: formData)
          .then((value) => value);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> deleteFont(String id) async {
    try {
      final response = await _client.delete(
          getUrl(
            Endpoints.deleteFonts,
          ),
          queries: {
            "id": id,
          });
      return RequestRes(
        response: response,
      );
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
