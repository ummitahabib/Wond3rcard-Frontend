class Apis {
  //----------------------System endpoints-----------------------------
  static const String healthCheck = 'sys/health-check';
  static const String status = 'sys/status';
  static const String uptime = 'sys/uptime';
  static const String environment = 'sys/environment';
  //----------------------Auth endpoints-----------------------------
  static const String signIn = 'sign-in';
  static const String signUp = 'users/sign-up';
  static const String user = 'get-user';
  static const String resetMfa = 'users/reset-mfa';
  static const String verifyAccount = 'users/verify-account';
  static const String deleteAccount = 'users/delete-account';
  static const String requestAccountVerification =
      'users/request-account-verification';
  static const String setupMfa = 'users/setup-mfa';

  static const String verifyMfa = 'users/verify-mfa';
  //----------------------Example endpoints-----------------------------
  static const String posts = 'posts';
}
