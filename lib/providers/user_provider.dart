import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = new User(email: "", token: "", refreshToken: "");

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
