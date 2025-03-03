import 'package:wond3rcard/src/authentication/data/models/login/input_model.dart';
import 'package:wond3rcard/src/utils/application_helpers.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:dio/dio.dart';

class SignUpRequest {
  String? firstName;
  String? lastName;
  String? otherName;
  String? email;
  String? workMail;
  String? password;
  String? companyName;
  String? jobTitle;
  String? mobileNumber;
  String? fcmToken;
  String? profilePhoto;
  String? coverPhoto;

  SignUpRequest({
    this.firstName,
    this.lastName,
    this.otherName,
    this.email,
    this.workMail,
    this.password,
    this.companyName,
    this.jobTitle,
    this.mobileNumber,
    required this.fcmToken,
    this.profilePhoto,
    this.coverPhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName ?? "",
      'lastName': lastName,
      'otherName': otherName ?? "",
      'email': email ?? "",
      'workMail': workMail ?? "",
      'password': password ?? "",
      'companyName': companyName ?? "",
      'jobTitle': jobTitle ?? "",
      'mobileNumber': mobileNumber ?? "",
      'fcmToken': fcmToken,
      'profilePhoto': profilePhoto ?? emptyString,
      'coverPhoto': coverPhoto ?? emptyString
    };
  }

  FormData toFormData() {
    return FormData.fromMap(toJson());
  }

  InputModel validateSignUpData() {
    // if (firstName!.length < 3) {
    //   return InputModel(error: AppStrings.inValidFirstName, isValidInput: false);
    // }
    // if (lastName!.length < 3) {
    //   return InputModel(error: AppStrings.inValidLastName, isValidInput: false);
    // }
    if (!ApplicationHelpers().isValidEmail(email!)) {
      return InputModel(error: AppStrings.inValidEmail, isValidInput: false);
    }
    return InputModel(error: "success", isValidInput: true);
  }
}
