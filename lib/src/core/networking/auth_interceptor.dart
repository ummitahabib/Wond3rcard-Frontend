import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends QueuedInterceptor {
  final String authTokenKey = "auth_token";

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Unsecure endpoints that don't require the Authorization header
    final unsecurePaths = [
      // Add your unsecure paths here, e.g., kSignUp, kSignIn
    ];

    // Skip adding the token if the endpoint is unsecure
    if (unsecurePaths.contains(options.path)) {
      return handler.next(options);
    }

    // Load token from SharedPreferences and add to headers
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey) ?? "";

    if (token.isNotEmpty) {
      debugPrint("READ - reading token from SharedPreferences");
      options.headers.addAll({'Authorization': "Bearer $token"});
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final dio = Dio();
    if (err.response != null) {
      if (err.response?.statusCode == 401) {
        // Handle 401 Unauthorized error

        // Extract the original request options
        final RequestOptions requestOptions = err.requestOptions;

        // Try refreshing the token (if applicable)
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString(authTokenKey) ?? "";

        if (accessToken.isNotEmpty) {
          dio.options.headers["Authorization"] = "Bearer $accessToken";
          dio.options.headers["Accept"] = "*/*";

          // Retry the original request with the updated token
          final opts = Options(method: requestOptions.method);
          final response = await dio.request(
            requestOptions.path,
            options: opts,
            cancelToken: requestOptions.cancelToken,
            onReceiveProgress: requestOptions.onReceiveProgress,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );

          return handler.resolve(response);
        }
      }
    }
    return handler.next(err);
  }
}
