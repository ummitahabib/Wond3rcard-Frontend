import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_analytics/data/models/analytics_request_model.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final adminAnalyticsRepoProvider =
    Provider((ref) => AdminAnalyticsRepository(client: ref.watch(apiProvider)));

class AdminAnalyticsRepository {
  final ApiClient _client;

  AdminAnalyticsRepository({required ApiClient client}) : _client = client;

  final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);

  Future<RequestRes> logAnalytics(
      Map<String, dynamic> requestBody) async {
    try {
      final response = await _client.post(getUrl(Endpoints.logAnalytics),
          data: requestBody);
      final resp = AdminAnalyticsRequestModel.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }


  Future<RequestRes> getAnalyticsInsight() async {
    try {
      final response = await _client.get(
        getUrl(Endpoints.getAllFlags),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final adminAnalyticsRequestModel =
          AdminAnalyticsRequestModel.fromJson(response);

      return RequestRes(response: AdminAnalyticsRequestModel);
    } catch (e) {
      print(e);
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}