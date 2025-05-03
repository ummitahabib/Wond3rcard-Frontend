import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_flag/data/models/create_flag_request.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final flagRepoProvider =
    Provider((ref) => FlagRepository(client: ref.watch(apiProvider)));

class FlagRepository {
  final ApiClient _client;

  FlagRepository({required ApiClient client}) : _client = client;

  final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);

  Future<RequestRes> createFlag(
      Map<String, dynamic> requestBody) async {
    try {
      final response = await _client.post(getUrl(Endpoints.createFlag),
          data: requestBody);
      final resp = CreateFlagRequest.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateFlag(
    Map<String, dynamic> requestBody,
    String flagId,
  ) async {
    try {
      final response = await _client.post(
          getUrl('${Endpoints.updateFlag}'),
          data: requestBody);
      final resp = CreateFlagRequest.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAllFlags() async {
    try {
      final response = await _client.get(
        getUrl(Endpoints.getAllFlags),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final createFlagRequest =
          CreateFlagRequest.fromJson(response);

      return RequestRes(response: CreateFlagRequest);
    } catch (e) {
      print(e);
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAllUsersFlags() async {
    try {
      final response = await _client.get(
        getUrl(Endpoints.getAllOrganization),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final List<dynamic> flagsJson = jsonResponse['payload']['flags'];

      final List<CreateFlagRequest> flags = flagsJson
          .map((organization) =>
              CreateFlagRequest.fromJson(organization))
          .toList();

      return RequestRes(response: flags);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }


  Future<RequestRes> getFlagByTier(String userTier) async {
    try {
      final response = await _client.get(
        getUrl('${Endpoints.getFlagByTier}'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final List<dynamic> flagsJson = jsonResponse['payload']['flags'];

      final List<CreateFlagRequest> flags = flagsJson
          .map((flag) =>
              CreateFlagRequest.fromJson(flag))
          .toList();

      return RequestRes(response: flags);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

 Future<RequestRes> deleteFlag(String id) async {
    try {
      final response = await _client.delete(
        getUrl('${Endpoints.deleteFlag}'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
