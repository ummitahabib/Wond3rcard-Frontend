import 'dart:convert';

import 'package:wond3rcard/src/authentication/data/models/login/input_model.dart';
import 'package:wond3rcard/src/utils/application_helpers.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class LoginModel {
  String? email;
  String? password;
  String? otpCode;
  String? mfaCode;
  String? status;
  String? message;
  String? accessToken;
  String? refreshToken;

  // Constructor for login input
  LoginModel({
    this.email,
    this.password,
    this.mfaCode,
    this.otpCode,
    this.status,
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  // Convert the object to JSON for sending login data
  String toJson() {
    final Map<String, dynamic> loginData = {
      "email": email,
      "password": password,
      "otpCode": otpCode,
      "mfaCode": mfaCode,
    };
    return jsonEncode(loginData);
  }

  // Validate login input fields
  InputModel validateLoginData() {
    final bool isValidEmail = ApplicationHelpers().isValidEmail(email ?? "");
    final String isValidPassword =
        ApplicationHelpers().isValidPassword(password ?? "") ??
            AppStrings.inValidPassword;
    if (!isValidEmail) {
      return InputModel(
        error: AppStrings.inValidEmail,
        isValidInput: false,
      );
    }

    if (isValidPassword != emptyString) {
      return InputModel(
        error: isValidPassword,
        isValidInput: false,
      );
    }
    return InputModel(
      error: "success",
      isValidInput: true,
    );
  }

  // Parse the response JSON into a LoginModel object
  LoginModel.fromJson({required Map<String, dynamic> responseData}) {
    status = responseData['status'] as String?;
    message = responseData['message'] as String?;

    final payload = responseData['payload'] as Map<String, dynamic>?;
    if (payload != null) {
      accessToken = payload['accessToken'] as String?;
      refreshToken = payload['refreshToken'] as String?;
    }
  }

  @override
  String toString() {
    return {
      "email": email,
      "password": password,
      "otpCode": otpCode,
      "mfaCode": mfaCode,
      "status": status,
      "message": message,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    }.toString();
  }
}
