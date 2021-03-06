// stores api urls
class AppUrl {
  static const String liveBaseURL = "im.godandanime.tv";
  static const String localBaseURL = "localhost:44381";

  static const String baseURL = liveBaseURL;
  static const String login = "/api/authentication/login";
  static const String signup = "/api/authentication/register";
  static const String forgotPassword = "/api/authentication/forgot-password";

  static const String add_report = "/api/observations";

  static const String refresh_token = "/api/Tokens/Refresh";
}
