import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'app_url.dart';
import 'user_preferences.dart';

// for tracking user status
enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

// this class provides authentication controller
class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _signedupStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _signedupStatus;

  // serves login
  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'user': {'email': email, 'password': password}
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    // sends user login info to server and get response
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.login),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode);
      print(response.body);
      // if success
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        var userData = responseData['data'];
        // converts json data to user model
        User authUser = User.fromJson(userData);
        // saves user info to storage
        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else {
        // if failed
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': response.body.isNotEmpty
              ? json.decode(response.body)['error']
              : 'server error',
        };
      }
    } on Exception catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      print("ERROR: $e.detail");
      return {
        'status': false,
        'message': 'Unsuccessful Request',
        'data': e,
      };
    }
    return result;
  }

  // serves signing up new user
  Future<Map<String, dynamic>> signup(String firstname, String lastname,
      String email, String phone, String jobTitle, String password) async {
    var result;

    final Map<String, dynamic> signupData = {
      'user': {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phone': phone,
        'jobTitle': jobTitle,
        'password': password,
      }
    };

    _signedupStatus = Status.Registering;
    notifyListeners();

    // sends user registration info to server and get response
    try {
      http.Response response = await http.post(Uri.parse(AppUrl.signup),
          body: json.encode(signupData),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        var userData = responseData['data'];

        User authUser = User.fromJson(userData);

        _signedupStatus = Status.Registered;
        UserPreferences().saveUser(authUser);
        result = {
          'status': true,
          'message': 'Registration successful',
          'data': authUser
        };
      } else {
        _signedupStatus = Status.NotRegistered;
        result = {
          'status': false,
          'message': response.body.isNotEmpty
              ? json.decode(response.body)['error']
              : 'server error',
        };
      }
    } on Exception catch (e) {
      _signedupStatus = Status.NotRegistered;
      print("the error is $e.detail");
      return {
        'status': false,
        'message': 'Unsuccessful Request',
        'data': e,
      };
    }

    return result;
  }

  // logs out user
  Future<void> logout() async {
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();
    // clears user data from local storage
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
