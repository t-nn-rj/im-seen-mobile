import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../models/user.dart';

// uses shared preferences to store user info
// it is for auto login
class UserPreferences {
  // save user info to storage
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.setString("userId", user.userId);
    prefs.setString("firstname", user.firstname);
    prefs.setString("lastname", user.lastname);
    prefs.setString("email", user.email);
    //prefs.setString("phone", user.phone);
    prefs.setString("jobTitle", user.jobTitle);
    prefs.setString("token", user.token);
    //prefs.setString("expiresIn", user.expiresIn);

    return true;
  }

  // retrive user info from storage
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //String userId = prefs.getString("userId");
    String firstname = prefs.getString("firstname");
    String lastname = prefs.getString("lastname");
    String email = prefs.getString("email");
    //String phone = prefs.getString("phone");
    String jobTitle = prefs.getString("jobTitle");
    String token = prefs.getString("token");
    //String expiresIn = prefs.getString("expiresIn");

    return User(
      //userId: userId,
      firstname: firstname,
      lastname: lastname,
      email: email,
      //phone: phone,
      jobTitle: jobTitle,
      token: token,
      //expiresIn: expiresIn
    );
  }

  // remove user info from storage
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.remove("userId");
    prefs.remove("firstname");
    prefs.remove("lastname");
    prefs.remove("email");
    //prefs.remove("phone");
    prefs.remove("jobTitle");
    prefs.remove("token");
    //prefs.remove("expiresIn");
  }

  // retrieves token from storage
  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
