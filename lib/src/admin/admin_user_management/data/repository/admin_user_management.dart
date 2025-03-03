import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/model/get_all_users/payload.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/util.dart';

final authRepositoryProvider = Provider(
    (ref) => AdminUserManagementRepository(client: ref.watch(apiProvider)));

class AdminUserManagementRepository {
  final ApiClient _client;

  AdminUserManagementRepository({required ApiClient client}) : _client = client;

  Future<RequestRes> getIntaraction() async {
    try {
      final String token = SessionString.accessTokenString;

      final response =
          await _client.get(getUrl(Endpoints.allUser), headers: {
        'Content-type': 'application/json',
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      final interaction = GetAllUsersPayload.fromJson(response);
      return RequestRes(response: interaction);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
