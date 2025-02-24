import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/organization/data/model/create_organization_request.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final organizationRepoProvider =
    Provider((ref) => OrganizationRepository(client: ref.watch(apiProvider)));

class OrganizationRepository {
  final ApiClient _client;

  OrganizationRepository({required ApiClient client}) : _client = client;

  final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);

  Future<RequestRes> createOrganization(
      Map<String, dynamic> requestBody) async {
    try {
      final response = await _client.post(getUrl(Endpoints.createOrganization),
          data: requestBody);
      final resp = CreateOrganizationRequest.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateOrganization(
    Map<String, dynamic> requestBody,
    String organizationId,
  ) async {
    try {
      final response = await _client.post(
          getUrl('${Endpoints.updateOrganization}$organizationId/update'),
          data: requestBody);
      final resp = CreateOrganizationRequest.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getUserOrganization() async {
    try {
      final response = await _client.get(
        getUrl(Endpoints.getUserOrganizations),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final createOrganizationRequest =
          CreateOrganizationRequest.fromJson(response);

      return RequestRes(response: createOrganizationRequest);
    } catch (e) {
      print(e);
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAllUsersOrganizations() async {
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
      final List<dynamic> organizationJson = jsonResponse['payload']['cards'];

      final List<CreateOrganizationRequest> organizations = organizationJson
          .map((organization) =>
              CreateOrganizationRequest.fromJson(organization))
          .toList();

      return RequestRes(response: organizations);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> addMemberToOrganization(
    CreateOrganizationRequest request,
  ) async {
    try {
      final response = await _client.post(
        getUrl(Endpoints.addMemberToOrganization),
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getUsersByOrganizationId(String organizationId) async {
    try {
      final response = await _client.get(
        getUrl('${Endpoints.getOrganizationsMembers}$organizationId/members'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> jsonResponse = jsonDecode(response);
      final List<dynamic> organizationJson = jsonResponse['payload']['cards'];

      final List<CreateOrganizationRequest> organizations = organizationJson
          .map((organization) =>
              CreateOrganizationRequest.fromJson(organization))
          .toList();

      return RequestRes(response: organizations);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> changeOrganizationMemberRole(
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _client.patch(
        getUrl(Endpoints.changeOrganizationRole),
        data: request,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> deleteOrganizationById(String id) async {
    try {
      final response = await _client.delete(
        getUrl('${Endpoints.deleteOrganization}$id/delete'),
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
