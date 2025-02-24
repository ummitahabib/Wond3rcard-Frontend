import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final previewProvider = ChangeNotifierProvider<PreviewNotifier>((ref) {
  return PreviewNotifier();
});

class PreviewNotifier extends ChangeNotifier {
  PreviewNotifier();

  String? firstName;
  String? lastName;
  String? jobTitle;
  String? companyName;
  String? workEmail;

  Future<void> loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString(OnboardingString.firstName);
    lastName = prefs.getString(OnboardingString.lastName);

    jobTitle = prefs.getString(OnboardingString.jobTitle);

    companyName = prefs.getString(OnboardingString.companyName);

    workEmail = prefs.getString(OnboardingString.workEmail);
    notifyListeners();
  }
}
