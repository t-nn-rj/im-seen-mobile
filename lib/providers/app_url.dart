// stores api urls
class AppUrl {
  static const String liveBaseURL = "http://im.godandanime.tv/api";
  static const String localBaseURL = "http://localhost/api";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/authenticate/login";
  static const String signup = baseURL + "/authenticate/register";
  static const String forgotPassword =
      baseURL + "/authenticate/forgot-password";

  static const String add_report = baseURL + "/observations";
}
