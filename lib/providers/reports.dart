import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/report.dart';
import 'app_url.dart';

class ReportProvider with ChangeNotifier {
  //final server = 'im.godandanime.tv';

  // uses http request to save a report to database
  Future<Report> addReport(Report report) async {
    final timestamp = DateTime.now();

    //final url = Uri.http(server, 'api/Reports');

    final response = await http.post(
      Uri.parse(AppUrl.add_report),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
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
  }
}
