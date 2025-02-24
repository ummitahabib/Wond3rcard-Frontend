import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final socialMediaRepositoryProvider =
    Provider((ref) => SocialMediaRepository(client: ref.watch(apiProvider)));

class SocialMediaRepository {
  final ApiClient _client;

  SocialMediaRepository({required ApiClient client}) : _client = client;

  final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);

  Future<RequestRes> createSocialMedia(SocialMedia socialMedia) async {
    try {
      final formData = FormData.fromMap(socialMedia.toMap());
      final response = await _client
          .post(getUrl(Endpoints.createSocialMedia), data: formData)
          .then((value) => value);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateSocialMedia(SocialMedia socialMedia) async {
    try {
      final formData = FormData.fromMap(socialMedia.toMap());
      final response = await _client
          .put(getUrl(Endpoints.updateSocialMedia), data: formData)
          .then((value) => value);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> deleteSocialMedia(String socialMediaId) async {
    try {
      final response = await _client.delete(
        getUrl('${Endpoints.deleteCard}$socialMediaId'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        },
      );
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getSocialMedias() async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      print('this is the token $token');
      final response = await _client.get(
        getUrl(Endpoints.getSocialMedia),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      // Parse response body
      final socialMediaResponse = SocialMediaResponse.fromMap(response);

      return RequestRes(response: socialMediaResponse);
    } catch (e) {
      print('this is the repo error $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
