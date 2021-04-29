import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './report.dart';

class Reports with ChangeNotifier {
  final server = 'im.godandanime.tv';

  // List<Report> _reports = [];

  // final String authToken;
  // final String userId;

  // Reports(this.authToken, this.userId, this._reports);

  // List<Report> get items {
  //   return [..._reports];
  // }

  // Report findById(String id) {
  //   return _reports.firstWhere((report) => report.reportId == id);
  // }

  // uses http request to save a report to database
  Future<Report> addReport(Report report) async {
    final timestamp = DateTime.now();

    final url = Uri.http(server, 'api/Reports');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        // TODO
        // uses userId properly after authentication works
        //'reporter': 1,
        //'studentId': null,
        //'reportID': 399,
        'studentName': report.studentName,
        'description': report.description,
        'severity': report.severity,
        'reportDate': timestamp.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      notifyListeners();
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create report.');
    }

    // TODO
    // gets the newly created report
    // final newReport = Report(
    //   reportId: report.reportId,
    //   userId: report.userId,
    //   studentName: report.studentName,
    //   description: report.description,
    //   severity: report.severity,
    //   dateTime: report.dateTime,
    // );
    // _reports.add(newReport);
  }
}
