import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/cards/data/model/card_model.dart';
import 'package:wond3rcard/src/cards/data/model/get_a_card.dart';
import 'package:wond3rcard/src/cards/data/model/get_all_cards.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/get_card.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final cardRepositoryProvider =
    Provider((ref) => CardRepository(client: ref.watch(apiProvider)));

class CardRepository {
  final ApiClient _client;

  CardRepository({required ApiClient client}) : _client = client;



  Future<RequestRes> createCard(Map<String, dynamic> requestBody) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      print('Request body: $requestBody');
      final response = await _client.put(
        getUrl(Endpoints.createCard),
        data: requestBody,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );
      print('API Response: ${response}');
      return RequestRes(response: response);
    } catch (e) {
      print('Repository error card repo: $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> createCardOrganization(
      Map<String, dynamic> requestBody) async {
    try {
      final response = await _client
          .put(getUrl(Endpoints.createCardOrganization), data: requestBody)
          .then((value) => value);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAllUsersCard() async {
    final String? token =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      final response = await _client.get(
        getUrl(Endpoints.getallUsersCard),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final GetCard cards = GetCard.fromMap(response);

      print('this is the response on card $cards');

      return RequestRes(response: cards);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getAUsersCard(String cardId) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _client.get(
        getUrl('${Endpoints.getAUserCard}$cardId'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        },
      );
      final cardResponse = GetCardsResponse.fromJson(response);
      return RequestRes(response: cardResponse);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> viewCard(String cardId) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _client.get(
        getUrl('${Endpoints.viewCard}$cardId'),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        },
      );
      final cardResponse = GetCardsResponse.fromJson(response);
      return RequestRes(response: cardResponse);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateUserCard(Map<String, dynamic> requestBody) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      print('Request body: $requestBody');
      final response = await _client.patch(
        getUrl(Endpoints.updateUserCard),
        data: requestBody,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );
      print('API Response: ${response.data}');
      return RequestRes(response: response);
    } catch (e) {
      print('Repository error: $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateOrganizationCard(
      Map<String, dynamic> requestBody) async {
          final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      print('Request body: $requestBody');
      final response = await _client.patch(
        getUrl(Endpoints.updateOrganizationCard),
        data: requestBody,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );
      print('API Response: ${response.data}');
      return RequestRes(response: response);
    } catch (e) {
      print('Repository error: $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateCard(Map<String, dynamic> requestBody) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      print('Request body: $requestBody');
      final response = await _client.patch(
        getUrl(Endpoints.updateCard),
        data: requestBody,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );
      print('API Response: ${response.data}');
      return RequestRes(response: response);
    } catch (e) {
      print('Repository error: $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> deleteCard(String cardId) async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _client.delete(
        getUrl('${Endpoints.deleteCard}$cardId'),
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

  Future<RequestRes> deleteUserOrgCard(
      Map<String, dynamic>? queries, String cardId) async {
          final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _client.delete(
        queries: queries,
        getUrl('${Endpoints.deleteUserOrgCard}$cardId'),
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

  Future<RequestRes> deleteAllCard() async {
      final String? authToken =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final response = await _client.delete(
        getUrl(Endpoints.deleteAllCards),
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
}
