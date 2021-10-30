import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/report.dart';
import '../models/user.dart';
import 'app_url.dart';
import 'user_preferences.dart';

class ReportProvider with ChangeNotifier {
  // uses http request to save a report to database
  Future<Map<String, dynamic>> addReport(Report report) async {
    var result;

    try {
      //Future.delayed(const Duration(milliseconds: 500), () {});
      final response = await postReport(report);
      //print(response.statusCode);
      //print(response.body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        notifyListeners();
        result = {
          'status': true,
          'loginAgain': false,
          'message': 'Successful',
          'data': responseData,
        };
      } else if (response.statusCode == 401) {
        // if token expires, try get new token
        User user = await UserPreferences().getUser();

        final queryParameters = {
          'accessToken': user.token,
          'refreshToken': user.refreshToken,
        };

        http.Response res = await http.post(
          Uri.http(AppUrl.baseURL, AppUrl.refresh_token, queryParameters),
          headers: {'Content-Type': 'application/json'},
        );

        //print(res.statusCode);
        //print(res.body);

        if (res.statusCode == 200) {
          // remove old user token
          // save new token
          final Map<String, dynamic> resData = json.decode(res.body);
          UserPreferences().removeUser();
          user = new User(
            email: user.email,
            token: resData['token'],
            refreshToken: resData['refreshToken'],
          );
          UserPreferences().saveUser(user);

          // send report again
          final resp = await postReport(report);
          //print(resp.statusCode);
          //print(resp.body);
          if (resp.statusCode == 201) {
            final Map<String, dynamic> respData = json.decode(resp.body);
            notifyListeners();
            result = {
              'status': true,
              'loginAgain': false,
              'message': 'Successful',
              'data': respData,
            };
          } else {
            notifyListeners();
            result = {
              'status': false,
              'loginAgain': false,
              'message': json.decode(resp.body)['message'],
            };
          }
        } else {
          // refresh token fails, login again
          notifyListeners();
          result = {
            'status': false,
            'loginAgain': true,
            'message': 'Session expired, please login again',
          };
        }
      } else {
        notifyListeners();
        result = {
          'status': false,
          'loginAgain': false,
          'message': json.decode(response.body)['message'],
        };
      }
    } on Exception catch (e) {
      //print("ERROR: $e.detail");
      return {
        'status': false,
        'loginAgain': false,
        'message': 'Unsuccessful Request',
        'data': e,
      };
    }
    return result;
  }

  Future<dynamic> postReport(Report report) async {
    final timestamp = DateTime.now();
    User user = await UserPreferences().getUser();
    final response = await http.post(
      Uri.http(AppUrl.liveBaseURL, AppUrl.add_report),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}',
      },
      body: jsonEncode({
        'StudentFirstName': report.firstname,
        'StudentLastName': report.lastname,
        //'studentName': report.firstname + " " + report.lastname,
        'UserName': user.email,
        'Description': report.description,
        'Severity': report.severity,
        'ObservationDate': timestamp.toIso8601String(),
        'Status': 'New',
      }),
    );
    return response;
  }
}
