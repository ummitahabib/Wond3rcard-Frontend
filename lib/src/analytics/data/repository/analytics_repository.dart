import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/analytics/data/model/interaction_request.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final analyticsRepoRepository =
    Provider((ref) => AnalyticsRepository(client: ref.watch(apiProvider)));

class AnalyticsRepository {
  final ApiClient _client;

  AnalyticsRepository({required ApiClient client}) : _client = client;

  Future<RequestRes> createInteract(Map<String, dynamic> requestBody) async {
    final String token = SessionString.accessTokenString;

    try {
      final response =
          await _client.post(getUrl(Endpoints.interact), data: requestBody);
      final resp = InteractionRequest.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getIntaraction() async {
    try {
      final String token = SessionString.accessTokenString;

      final response =
          await _client.get(getUrl(Endpoints.getAnalytics), headers: {
        'Content-type': 'application/json',
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      final interaction = AnalyticsResponse.fromJson(response);
      return RequestRes(response: interaction);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getIntaractionByTime(String time) async {
    try {
      final String token = SessionString.accessTokenString;

      final response = await _client.get(
          getUrl(
            "${Endpoints.getAnalyticsByTimePeriod}$time",
          ),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          });
      final interaction = InteractionRequest.fromJson(response);
      return RequestRes(response: interaction);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
