import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/core/networking/auth_interceptor.dart';
import 'package:wond3rcard/src/core/networking/config.dart';
import 'package:wond3rcard/src/core/networking/data_exception.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final apiProvider = Provider((ref) {
  return ApiClient(ref: ref);
});

class ApiClient {
  final Ref ref;

  ApiClient({
    required this.ref,
  });

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _getDio()
          .get(
            url,
            queryParameters: queries,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: 120));
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);
      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _getDio()
          .delete(
            url,
            queryParameters: queries,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: 120));

      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);
      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      final response = await _getDio()
          .post(
            url,
            options: options,
            data: data,
            queryParameters: query,
          )
          .timeout(const Duration(seconds: 120));
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);

      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> upload(
    String url, {
    required Map<String, dynamic> data,
  }) async {
    final String? accessToken =
        StorageUtil.getString(key: SessionString.accessTokenString);

    try {
      final response = await _getDio().post(
        url,
        options: Options(
          headers: {
            "content-type": "multipart/form-data",
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: FormData.fromMap(data),
      );

      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);
      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      final response = await _getDio()
          .patch(
            url,
            options: options,
            data: data,
            queryParameters: query,
          )
          .timeout(const Duration(seconds: 120));
      final responseJson = _returnResponse(response);
      return responseJson;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);

      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> put(
    String url, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _getDio()
          .put(
            url,
            options: options,
            data: data,
          )
          .timeout(const Duration(seconds: 120)); // Timeout configuration

      // Process and return the response
      return _returnResponse(response);
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      final msg = DataException.fromDioError(e);
      if (e.response == null || e.response!.data == null) {
        throw Exception("Network error: ${msg.message}");
      } else {
        throw processError(e.response!); // Process error for non-null response
      }
    } on TimeoutException catch (e) {
      // Handle timeout-specific exceptions
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      // Handle generic exceptions
      throw Exception("An unexpected error occurred: $e");
    }
  }

  dynamic _returnResponse(Response response) {
    try {
      if (!isResponseOk(response.statusCode!)) {
        throw processError(response);
      }

      return response.data ?? true;
    } on DioException catch (e) {
      final msg = DataException.fromDioError(e);

      if (e.response == null || e.response!.data == null) {
        throw Exception(msg.message);
      } else {
        throw processError(e.response!);
      }
    }
  }

  bool isResponseOk(int statusCode) {
    if (statusCode == 401) {
      // SnackbarUtil.showErrorSnack(navigatorKey.currentState!.context, "Session Expired. Please Login Again");
      // Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.context, LoginPage.routeName, (route) => false);
    }
    return statusCode >= 200 && statusCode <= 299;
  }

  dynamic processError(Response response) {
    if (response.statusCode == 401 &&
        (response.data["message"].toString().contains("Invalid token") ||
            response.data["message"]
                .toString()
                .contains("Your session has ended. Please re-login"))) {
      return response.data["message"] ??
          response.data["error_description"] ??
          response.data["error"] ??
          response.data["status"] ??
          "Server error. Please contact support for help.";
      // SnackbarUtil.showErrorSnack(navigatorKey.currentState!.context, "Session Expired. Please Login Again");
      // Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.context, LoginPage.routeName, (route) => false);
    }
    return response.data["message"] ??
        response.data["error_description"] ??
        response.data["error"] ??
        response.data["status"] ??
        "Server error. Please contact support for help.";
  }

  Dio _getDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Config.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.addAll([
        AuthInterceptor(),
        LogInterceptor(requestBody: true, responseBody: true),
        _CustomInterceptor(),
      ]);
    } else {
      dio.interceptors.addAll([AuthInterceptor()]);
    }
    return dio;
  }
}

class _CustomInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Set validateStatus to always return true (ignore all status codes)
    options.validateStatus = (status) => true;
    return handler.next(options); // continue with the request
  }
}
