import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './report.dart';

class Reports with ChangeNotifier {
  List<Report> _reports = [];

  final String authToken;
  final String userId;

  Reports(this.authToken, this.userId, this._reports);

  List<Report> get items {
    return [..._reports];
  }

  Report findById(String id) {
    return _reports.firstWhere((report) => report.reportId == id);
  }

  // uses http request to save a report to database
  Future<void> addReport(Report report) async {
    final timestamp = DateTime.now();
    final url =
        Uri.https('im.godandanime.tv/', '/reports.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'reportId': report.reportId,
          'userId': report.userId,
          'studentName': report.studentName,
          'description': report.description,
          'severity': report.severity,
          'dateTime': timestamp.toIso8601String(),
        }),
      );
      final newReport = Report(
        reportId: report.reportId,
        userId: report.userId,
        studentName: report.studentName,
        description: report.description,
        severity: report.severity,
        dateTime: report.dateTime,
      );
      _reports.add(newReport);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
