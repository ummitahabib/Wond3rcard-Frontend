
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/onboarding/data/model/onboarding_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final onboardingProvider =
    ChangeNotifierProvider<OnboardingModelNotifier>((ref) {
  return OnboardingModelNotifier();
});

class OnboardingModelNotifier extends ChangeNotifier {
  OnboardingModelNotifier();

  XFile? uploadedImage;
  Uint8List? uploadedImageBytes;


  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }


  OnboardingModel _onboardingModel = OnboardingModel(
    firstName: '',
    lastName: '',
    phoneNumber: '',
    workEmail: '',
    companyName: '',
    jobTitle: '',
    photo: '',
    website: '',
  );

  OnboardingModel get onboardingModel => _onboardingModel;

  set onboardingModel(OnboardingModel model) {
    _onboardingModel = model;
    notifyListeners();
  }

  Future<void> saveImageToPreferences(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', imagePath);
  }

  Future<void> loadStoredImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      uploadedImage = XFile(imagePath);
      notifyListeners();
    }
  }




  
  Future<void> pickImage({ImageSource? source}) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: source ?? ImageSource.gallery);
    
    if (imageFile != null) {
      uploadedImage = imageFile;
      
      if (kIsWeb) {
        uploadedImageBytes = await imageFile.readAsBytes();
      }

      notifyListeners();
      await saveImageToPreferences(imageFile.path);
    }
  }

  Future<Uint8List> getImageBytes() async {
    if (uploadedImageBytes != null) {
      return uploadedImageBytes!;
    }
    return Uint8List(0);
  }


  Future<void> saveUserDetails(
      {String? firstName,
      String? lastName,
      String? phoneNumber,
      String? workEmail,
      String? companyName,
      String? jobTitle,
      String? photo,
      String? website}) async {
    await StorageUtil.putString(
        key: OnboardingString.firstName, value: firstName ?? emptyString);
    await StorageUtil.putString(
        key: OnboardingString.lastName, value: lastName ?? emptyString);
    await StorageUtil.putString(
        key: OnboardingString.phoneNumber, value: phoneNumber ?? emptyString);
    await StorageUtil.putString(
        key: OnboardingString.workEmail, value: workEmail ?? emptyString);

    await StorageUtil.putString(
        key: OnboardingString.companyName, value: companyName ?? emptyString);

    await StorageUtil.putString(
        key: OnboardingString.jobTitle, value: jobTitle ?? emptyString);

    await StorageUtil.putString(
        key: OnboardingString.photo, value: photo ?? emptyString);

    await StorageUtil.putString(
        key: OnboardingString.website, value: website ?? emptyString);
  }

  Future<Map<String, String?>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "firstName": prefs.getString(OnboardingString.firstName),
      "lastName": prefs.getString(OnboardingString.lastName),
    };
  }

Future<void> checkOnboardingStatus(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (isFirstTime) {
    context.go(RouteString.getStarted);
  } else {
     context.go(RouteString.logIn);
  }
}

}


