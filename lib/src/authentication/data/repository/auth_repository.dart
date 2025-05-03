import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/models/login/login_request.dart';
import 'package:wond3rcard/src/core/networking/api_client.dart';
import 'package:wond3rcard/src/core/networking/end_points.dart';
import 'package:wond3rcard/src/core/networking/request_res.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(client: ref.watch(apiProvider)));

class AuthRepository {
  final ApiClient _client;

  AuthRepository({required ApiClient client}) : _client = client;

  Future<RequestRes> login(String requestBody) async {
    try {
      final response =
          await _client.post(getUrl(Endpoints.login), data: requestBody);
      final resp = LoginModel.fromJson(responseData: response);
      return RequestRes(response: resp);
    } catch (e) {
      print('this is the error auth repo ${e.toString()}');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> signUp(String requestBody) async {
    try {
      final requestData = json.decode(requestBody);
      final formData = FormData.fromMap(requestData);

      final response = await _client
          .post(getUrl(Endpoints.signUp), data: formData)
          .then((value) => value);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> resetMfa({required int code}) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final Map<String, dynamic> data = {
        "code": code,
      };
      final response = _client.post(
        getUrl(Endpoints.resetMfa),
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<RequestRes> verifyAccount(
      {required String email, required String otp}) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "otp": otp,
      };
      final response = await _client.post(
        getUrl(Endpoints.verifyAccount),
        data: data,
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<void> deleteAccount() async {
    try {
      final String? token =
          StorageUtil.getString(key: SessionString.accessTokenString);
      Response response = await _client.delete(
        "auth-delete-account",
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to delete subscription");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<RequestRes> requestAccountVerfication({required String email}) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final Map<String, dynamic> data = {
        "email": email,
      };
      final response = await _client.post(
        getUrl(Endpoints.requestAccountVerification),
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<RequestRes> userSetupMfa(
      {required String email, required String code}) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "code": code,
      };
      final response = await _client.post(
        getUrl(Endpoints.userSetupMfa),
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<RequestRes> verifyMfa({required String code}) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final Map<String, dynamic> data = {
        "code": code,
      };
      final response = await _client.post(
        getUrl(Endpoints.verifyMfa),
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<RequestRes> resetPassword(
      {required String email,
      required String newPassword,
      required String confirmNewPassword}) async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword
      };
      final response = await _client.post(
        getUrl(Endpoints.resetPassword),
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(
        error: ErrorRes(message: e.toString()),
      );
    }
  }

  Future<RequestRes> forgotPassword(Map<String, dynamic> requestBody) async {
    try {
      final response = await _client
          .post(getUrl(Endpoints.forgotPassword), data: requestBody)
          .then((value) => value);
      return RequestRes(response: response.toString());
    } catch (e) {
      print('this is the forgetpassword error $e');
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<void> logout() async {
          final String? token =
      StorageUtil.getString(key: SessionString.accessTokenString);
    try {
      await _client.post(
        getUrl('auth/logout'),
        
        options: Options(
           headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        )
      );
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
