import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final profileRepoProvider =
    Provider((ref) => AuthRepository(client: ref.watch(apiProvider)));

class AuthRepository {
  final ApiClient _client;

  AuthRepository({required ApiClient client}) : _client = client;

  Future<RequestRes> getProfile() async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      print('this is the token $token');
      final response = await _client.get(
        getUrl(Endpoints.profile),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final profileResponse = UserProfileResponse.fromJson(response);

      return RequestRes(response: profileResponse);
    } catch (e) {
      print('this is the repo error $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
