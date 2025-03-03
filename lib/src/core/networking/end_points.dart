class Endpoints {
  static const String devBaseUrl =
      "https://wond3rd-card-apis-q7hk5.ondigitalocean.app/api/";
  static const String prodBaseUrl =
      "https://wond3rd-card-apis-q7hk5.ondigitalocean.app/api/";
  static bool isLiveEnvironment = false;
  static String baseUrl = isLiveEnvironment ? prodBaseUrl : devBaseUrl;
  static const String login = "auth/sign-in";
  static const String signup = "auth/sign-up";
  static const String healthCheck = 'sys/health-check';
  static const String status = 'sys/status';
  static const String uptime = 'sys/uptime';
  static const String environment = 'sys/environment';
  //----------------------Auth endpoints-----------------------------
  static const String signIn = 'auth/sign-in';
  static const String signUp = 'auth/sign-up';
  static const String resetMfa = 'auth/reset-mfa';
  static const String verifyAccount = 'auth/verify-account';
  static const String deleteAccount = 'auth/delete-account';
  static const String resetPassword = "auth/change-password";
  static const String requestAccountVerification =
      'auth/request-verify-account';
  static const String setupMfa = 'auth/setup-mfa';

  static const String verifyMfa = 'auth/verify-mfa';

  //----------------------Profile endpoints-----------------------------
  static const String profile = "users/user-profile";
  static const String user = 'users/user-profile';
  static const String allUser = 'admin/all-users';
  static const String changeUserRole = 'users/change-user-role';
  static const String changeUserType = 'users/change-user-type';
  static const String changeUserStatus = 'users/change-user-status';

  //----------------------Example endpoints-----------------------------
  static const String posts = 'posts';
  static const String userSetupMfa = '';
  static const String forgotPassword = 'forgot-password';

//---------------------- organization endpoints-----------------------------

  static const String createOrganization = 'organizations/create';
  static const String getUserOrganizations = 'organizations/user-organizations';
  static const String getAllOrganization = 'organizations/';
  static const String addMemberToOrganization = 'organizations/add-member';
  static const String getOrganizationsMembers = 'organizations/';
  static const String changeOrganizationRole = 'organizations/';
  static const String updateOrganization = 'organizations/';

  static const String deleteOrganization = 'organizations/';

//---------------------- card endpoints-----------------------------

  static const String createCard = 'cards/create';
  static const String createCardOrganization = 'cards/create-team';
  static const String getallUsersCard = 'cards/';
  static const String getAUserCard = 'cards/get-card/';
  static const String viewCard = 'cards/view-card/';
  static const String deleteCard = 'cards/delete-card/';
  static const String deleteUserOrgCard = 'cards/delete-user-org-card';
  static const String deleteAllCards = 'cards/delete-all-cards/';
  static const String updateUserCard = 'cards/update-user-org-card/';
  static const String updateOrganizationCard = 'cards/update-org-card/';
  static const String updateCard = 'cards/update-card/';

//---------------------- admin users endpoints-----------------------------

  static const String adminChangeUserRole = 'users/change-user-role';
  static const String adminChangeUserType = 'users/change-user-type';
  static const String adminChangeUserStatus = 'users/change-user-status';

  static const String createSocialMedia = 'social-medias/';
  static const String updateSocialMedia = 'update/social-medias';
  static const String deleteSocailMedia = 'delete/social-medias';
  static const String getSocialMedia = 'social-medias/';

//---------------------- fonts endpoints-----------------------------

  static const String uploadFonts = 'fonts/';
  static const String getFonts = 'fonts/';
  static const String updateFonts = 'fonts/';
  static const String deleteFonts = 'fonts/';

//---------------------- interaction-analytics endpoints-----------------------------
  static const String interact = 'interaction/';
  static const String getAnalytics = 'interaction/';
  static const String getAnalyticsByTimePeriod =
      'interaction/by-time-period/?timePeriod';
  static const String getUserCardAnalytics =
      'interaction/user-card-analytics?cardId=676fbb644d3061c0b3a4839c';
}

String getUrl(String route) {
  return Endpoints.devBaseUrl + route;
}
