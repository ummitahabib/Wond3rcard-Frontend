class Config {
  static const String devBaseUrl = '';
  static const String prodBaseUrl = '';
  static bool isLiveEnvironment = false;
  static String baseUrl = isLiveEnvironment ? prodBaseUrl : devBaseUrl;
}
