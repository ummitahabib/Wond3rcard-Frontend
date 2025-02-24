import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class HeaderInterceptors extends Interceptor {
  Future<String?> getAuthToken() async {
    final String? authToken =
        StorageUtil.getString(key: SessionString.accessTokenString);

    return authToken;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    // Add Authorization header only if the request requires it
    if (!options.uri.toString().contains('/sign-up') &&
        !options.uri.toString().contains('/login')) {
      String? token = await getAuthToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Handle special cases for multipart/form-data requests
    if (options.uri.toString().contains('/driver/register')) {
      options.headers['Content-Type'] = 'multipart/form-data';
    }

    // Log request for debugging
    print("Request to ${options.uri} with headers: ${options.headers}");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response for debugging
    print("Response from ${response.requestOptions.uri}: ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 errors for token refresh
    if (err.response?.statusCode == 401) {
      final newToken = await refreshToken();
      if (newToken != null) {
        // Retry the failed request with the new token
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final clonedRequest = await Dio().fetch(err.requestOptions);
        return handler.resolve(clonedRequest);
      }
    }

    // Log error for debugging
    print("Error during request to ${err.requestOptions.uri}: ${err.message}");
    return handler.next(err);
  }

  Future<String?> refreshToken() async {
    final String? refreshedToken =
        StorageUtil.getString(key: SessionString.refreshTokenString);

    // Simulate refreshing the token
    print("Refreshing token...");
    await Future.delayed(const Duration(seconds: 1)); // Simulated delay
    return refreshedToken; // Replace with real logic
  }
}
