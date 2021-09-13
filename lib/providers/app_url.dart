// stores api urls
class AppUrl {
  static const String liveBaseURL = "http://im.godandanime.tv/api";
  static const String localBaseURL = "http://localhost/api";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login";
  static const String signup = baseURL + "/signup";
  static const String forgotPassword = baseURL + "/forgot-password";

  static const String add_report = baseURL + "/Reports";
}
