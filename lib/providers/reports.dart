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
    final timestamp = DateTime.now();

    try {
      User user = await UserPreferences().getUser();
      final response = await http.post(
        Uri.http(AppUrl.baseURL, AppUrl.add_report),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}',
        },
        body: jsonEncode({
          //'firstname': report.firstname,
          //'lastname': report.lastname,
          'studentName': report.firstname + " " + report.lastname,
          'userName': user.email,
          'description': report.description,
          'severity': report.severity,
          'observationDate': timestamp.toIso8601String(),
        }),
      );

      //print(response.statusCode);
      //print(response.body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        notifyListeners();
        result = {
          'status': true,
          'message': 'Successful',
          'data': responseData,
        };
      } else {
        notifyListeners();
        result = {
          'status': false,
          'message': json.decode(response.body)['message'],
        };
      }
    } on Exception catch (e) {
      //print("ERROR: $e.detail");
      return {
        'status': false,
        'message': 'Unsuccessful Request',
        'data': e,
      };
    }
    return result;
  }
}
