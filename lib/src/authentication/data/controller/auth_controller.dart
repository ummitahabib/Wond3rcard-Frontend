import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/authentication/data/models/login/input_model.dart';
import 'package:wond3rcard/src/authentication/data/models/login/login_request.dart';
import 'package:wond3rcard/src/authentication/data/models/signup/signup_request.dart';
import 'package:wond3rcard/src/authentication/data/repository/auth_repository.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/token_services.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginReturnData { success, unverifiedEmail, error }

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends ChangeNotifier {
  bool _mounted = true;

  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  final Ref ref;

  AuthNotifier(this.ref);

  bool _loadingLogin = false;

  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool state) {
    _loadingLogin = state;
    if (mounted) notifyListeners();
  }

  bool _loadingSignup = false;

  bool get loadingSignup => _loadingSignup;

  set loadingSignup(bool state) {
    _loadingSignup = state;
    if (mounted) notifyListeners();
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    if (mounted) notifyListeners();
  }

  final String? emailAddress = StorageUtil.getString(key: userEmail);

  final TextEditingController pinCode1 = TextEditingController();
  final TextEditingController pinCode2 = TextEditingController();
  final TextEditingController pinCode3 = TextEditingController();
  final TextEditingController pinCode4 = TextEditingController();
  final TextEditingController pinCode5 = TextEditingController();
  final TextEditingController pinCode6 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController otherName = TextEditingController();
  TextEditingController workMail = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final fcmToken = TokenService().generateFCMToken();

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  Future<LoginReturnData> login(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String otpCode = '';
    final String mfaCode = '';

    if (email.isEmpty || password.isEmpty) {
      alert.showErrorToast(message: 'Email and Password are required');
      return LoginReturnData.error;
    }
    loadingLogin = true;
    final LoginModel loginModel = LoginModel(
      email: email,
      password: password,
      mfaCode: mfaCode,
      otpCode: otpCode,
    );

    final InputModel isValidLoginInput = loginModel.validateLoginData();

    if (!isValidLoginInput.isValidInput) {
      alert.showErrorToast(message: isValidLoginInput.error);
      return LoginReturnData.error;
    }

    try {
      final response =
          await ref.read(authRepositoryProvider).login(loginModel.toJson());

      if (response.error != null) {
        alert.showErrorToast(
            message: response.error!.message ?? 'Unknown error');
        if (response.error!.message ==
            AppStrings.unVerifiedAccountErrorMessage) {
          return LoginReturnData.unverifiedEmail;
        }
        return LoginReturnData.error;
      }

      final LoginModel loginResponse = response.response as LoginModel;
      if (loginResponse.accessToken != null) {
        await storeLoginData(loginResponse, context);
        return LoginReturnData.success;
      }

      alert.showErrorToast(message: 'Login failed. Invalid credentials.');
      return LoginReturnData.error;
    } catch (e, stacktrace) {
      debugPrint('Login failed: $e\n$stacktrace');
      alert.showErrorToast(message: 'Unable to complete process. Try again.');
      return LoginReturnData.error;
    } finally {
      loadingLogin = false;
    }
  }

  Future<void> storeLoginData(
      LoginModel loginResponse, BuildContext context) async {
    final String accessToken =
        loginResponse.accessToken ?? AppStrings.emptyString;
    final String refreshToken =
        loginResponse.refreshToken ?? AppStrings.emptyString;

    print('##### Saving Access Token: $accessToken');
    print('##### Saving Refresh Token: $refreshToken');

    await StorageUtil.putString(
      key: SessionString.accessTokenString,
      value: accessToken,
    );

    await StorageUtil.putString(
      key: SessionString.refreshTokenString,
      value: refreshToken,
    );

    await ref.watch(profileProvider).getProfile(context);

    clearControllers();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final String? accessToken =
        await StorageUtil.getString(key: SessionString.accessTokenString);

    print("Retrieved Access Token: $accessToken");

    if (accessToken != null && accessToken.isNotEmpty) {
      context.go(RouteString.baseDashboard);
    } else {
      context.go(RouteString.getStarted);
    }
  }

  Future<bool> signUp(BuildContext context) async {
    String? base64Image;
    try {
      loadingSignup = true;

      // Retrieve stored profile image path
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedImagePath = prefs.getString('profileImage');

      if (storedImagePath != null && storedImagePath.isNotEmpty) {
        if (kIsWeb) {
          final Uint8List? imageBytes =
              ref.read(onboardingProvider).uploadedImageBytes;
          if (imageBytes != null) {
            base64Image = base64Encode(imageBytes);
          }
        } else {
          final File imageFile = File(storedImagePath);
          final List<int> imageBytes = await imageFile.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }
      }

      // Prepare signup data
      final SignUpRequest signupData = SignUpRequest(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        otherName: otherName.text.trim(),
        email: emailController.text.trim(),
        workMail: workMail.text.trim(),
        password: passwordController.text.trim(),
        companyName: companyNameController.text.trim(),
        jobTitle: jobTitleController.text.trim(),
        mobileNumber: phoneNumberController.text.trim(),
        profilePhoto: base64Image,
        fcmToken: fcmToken,
      );

      // Validate signup data
      final InputModel isValidSignUpInput = signupData.validateSignUpData();
      if (!isValidSignUpInput.isValidInput) {
        alert.showErrorToast(message: isValidSignUpInput.error);
        return false;
      }

      // Save email to storage
      StorageUtil.putString(key: userEmail, value: emailController.text.trim());

      // Make signup request
      final response = await ref.read(authRepositoryProvider).signUp(
            json.encode(signupData.toJson()),
          );

      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
        return false;
      } else {
        clearControllers();
        context.go(RouteString.otpVerification);
        return true;
      }
    } catch (e) {
      debugPrint("SignUp Error: $e");
      alert.showErrorToast(message: "An unexpected error occurred.");
      return false;
    } finally {
      loadingSignup = false;
    }
  }

  Future<bool> resetMfaWithCode(int mfaCode) async {
    loading = true;
    try {
      final result = await ref.read(authRepositoryProvider).resetMfa(
            code: mfaCode,
          );
      if (result.error != null) {
        alert.showErrorToast(
            message: "Error resetting MFA: ${result.error?.message}");
        return false;
      } else {
        alert.showSuccessToast(message: "MFA reset successful");
        return true;
      }
    } catch (e) {
      log("Exception during MFA reset: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  Future<bool> verifyUserAccount(
      {required String email,
      required String otp,
      required BuildContext context}) async {
    loading = true;
    try {
      final result = await ref.read(authRepositoryProvider).verifyAccount(
            email: email,
            otp: otp,
          );
      if (result.error != null) {
        alert.showErrorToast(message: result.error?.message ?? emptyString);
        return false;
      } else {
        context.go(RouteString.logIn);
        alert.showSuccessToast(message: "Account verification successful");
        return true;
      }
    } catch (e) {
      alert.showErrorToast(
          message: "Exception during account verification: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  Future<bool> requestAccountVerfication({required String email}) async {
    loading = true;
    try {
      final result =
          await ref.read(authRepositoryProvider).requestAccountVerfication(
                email: email,
              );
      if (result.error != null) {
        log("Error verifying account: ${result.error?.message}");
        return false;
      } else {
        log("Account verification successful");
        return true;
      }
    } catch (e) {
      log("Exception during account verification: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  Future<bool> forgotPassword() async {
    try {
      loading = true;
      final a = {
        "email": emailController.text,
      };
      final response = await ref.read(authRepositoryProvider).forgotPassword(a);
      if (response.hasError()) {
        alert.showErrorToast(message: response.error?.message ?? emptyString);
      } else {
        alert.showSuccessToast(message: 'Email Sent');
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
    } finally {
      if (mounted) loading = false;
    }
    return false;
  }

  Future<bool> userSetUpMfa(
      {required String email, required String code}) async {
    loading = true;
    try {
      final result = await ref.read(authRepositoryProvider).userSetupMfa(
            email: email,
            code: code,
          );
      if (result.error != null) {
        log("Error verifying account: ${result.error?.message}");
        return false;
      } else {
        log("Account verification successful");
        return true;
      }
    } catch (e) {
      log("Exception during account verification: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  Future<bool> verifyMfa(String code) async {
    loading = true;
    try {
      final result = await ref.read(authRepositoryProvider).verifyMfa(
            code: code,
          );
      if (result.error != null) {
        log("Error verifying MFA: ${result.error?.message}");
        return false;
      } else {
        log("MFA verify successful");
        return true;
      }
    } catch (e) {
      log("Exception during MFA erification: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  Future<void> signInMethod(BuildContext context) async {
    loadingLogin = true;
    try {
      final LoginReturnData loginData = await login(context);

      if (loginData == LoginReturnData.unverifiedEmail) {
        context.go(RouteString.verifyAccount);
      } else if (loginData == LoginReturnData.success) {
        context.go(RouteString.baseDashboard);
      } else {
        alert.showErrorToast(message: 'Unable to log in. Please try again.');
      }
    } catch (e) {
      debugPrint('Login error: $e');
      alert.showErrorToast(message: 'An error occurred during login.');
    } finally {
      loadingLogin = false;
    }
  }

  Future<bool> resetPassword() async {
    loading = true;
    try {
      final result = await ref.read(authRepositoryProvider).resetPassword(
            email: email,
            newPassword: passwordController.text.trim(),
            confirmNewPassword: confirmPassword.text.trim(),
          );
      if (result.error != null) {
        log("Error verifying account: ${result.error?.message}");
        return false;
      } else {
        log("Password reset successful");
        return true;
      }
    } catch (e) {
      log("Exception during account password reset: $e");
      return false;
    } finally {
      if (mounted) loading = false;
    }
  }

  void otpInputMethod(
      TextEditingController pinCode1,
      TextEditingController pinCode2,
      TextEditingController pinCode3,
      TextEditingController pinCode4,
      TextEditingController pinCode5,
      TextEditingController pinCode6,
      WidgetRef ref,
      String emailAddress,
      BuildContext context) {
    final otpCode = pinCode1.text +
        pinCode2.text +
        pinCode3.text +
        pinCode4.text +
        pinCode5.text +
        pinCode6.text;
    if (otpCode.length == SpacingConstants.int6) {
      verifyUserAccount(email: emailAddress, otp: otpCode, context: context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
    }
  }

  void otpInputMethodAndNavigateToChangePassword(
      TextEditingController pinCode1,
      TextEditingController pinCode2,
      TextEditingController pinCode3,
      TextEditingController pinCode4,
      TextEditingController pinCode5,
      TextEditingController pinCode6,
      WidgetRef ref,
      BuildContext context) {
    final otpCode = pinCode1.text +
        pinCode2.text +
        pinCode3.text +
        pinCode4.text +
        pinCode5.text +
        pinCode6.text;
    if (otpCode.length == SpacingConstants.int6) {
      verifyUserAccount(
          email: emailAddress ?? emptyString, otp: otpCode, context: context);
      context.go(RouteString.logIn);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
    }
  }
}

final deleteAccountProvider =
    StateNotifierProvider<DeleteAccountNotifier, AsyncValue<void>>(
  (ref) => DeleteAccountNotifier(ref.read(authRepositoryProvider)),
);

class DeleteAccountNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;

  DeleteAccountNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> deleteAccount(String id, String newTierId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteAccount();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final logoutControllerProvider =
    StateNotifierProvider<LogoutController, AsyncValue<void>>(
  (ref) => LogoutController(ref.read(authRepositoryProvider)),
);

class LogoutController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  LogoutController(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
