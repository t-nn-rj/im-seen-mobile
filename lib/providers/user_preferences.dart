import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../models/user.dart';

// uses shared preferences to store user info
// it is for auto login
class UserPreferences {
  // save user info to storage
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("firstname", user.firstname);
    prefs.setString("lastname", user.lastname);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("jobTitle", user.jobTitle);
    //prefs.setString("deptId", user.deptId);
    //prefs.setString("roleId", user.roleId);
    //prefs.setString("groupId", user.groupId);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);

    return true;
  }

  // retrive user info from storage
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String firstname = prefs.getString("firstname");
    String lastname = prefs.getString("lastname");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String jobTitle = prefs.getString("jobTitle");
    //String deptId = prefs.getString("deptId");
    //String roleId = prefs.getString("roleId");
    //String groupId = prefs.getString("groupId");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        jobTitle: jobTitle,
        //deptId: deptId,
        //roleId: roleId,
        //groupId: groupId,
        token: token,
        renewalToken: renewalToken);
  }

  // remove user info from storage
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("firstname");
    prefs.remove("lastname");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("jobTitle");
    prefs.remove("token");
    //prefs.remove("deptId");
    //prefs.remove("roleId");
    //prefs.remove("groupId");
  }

  // retrieves token from storage
  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
