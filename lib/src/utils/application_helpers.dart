import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class ApplicationHelpers {
  String? isValidPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return emptyPhoneNumberCheck;
    }
    String numericPhoneNumber =
        phoneNumber.replaceAll(RegExp(r'\D'), AppStrings.emptyString);
    const int minPhoneNumberLength = SpacingConstants.int8;
    const int maxPhoneNumberLength = SpacingConstants.int10;
    if (numericPhoneNumber.length < minPhoneNumberLength ||
        numericPhoneNumber.length > maxPhoneNumberLength) {
      return phoneLenghtNumberCheck;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(numericPhoneNumber)) {
      return phoneNumberCheck;
    }
    return AppStrings.emptyString;
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String? isValidPassword(String password) {
    RegExp symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    RegExp alphanumericRegex = RegExp(r'[a-zA-Z0-9]');
    if (password.isEmpty) {
      return emptyPasswordCheck;
    }
    if (!symbolRegex.hasMatch(password)) {
      return specialCharCheck;
    }
    if (!capitalLetterRegex.hasMatch(password)) {
      return capitalLetterCheck;
    }
    if (!alphanumericRegex.hasMatch(password)) {
      return numericCheck;
    }
    if (password.length < 8) {
      return passwordLimitCheck;
    }
    return AppStrings.emptyString;
  }

  String? isValidNumeric(String? number) {
    if (number == null || number.isEmpty) {
      return emptyNumberCheck;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(number)) {
      return numberCheck;
    }

    return AppStrings.emptyString;
  }
}
