import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Report with ChangeNotifier {
  String reportId;
  int userId;
  String studentName;
  String description;
  int severity;
  DateTime dateTime;

  Report({
    @required this.reportId,
    @required this.userId,
    @required this.studentName,
    @required this.description,
    @required this.severity,
    @required this.dateTime,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['id'],
      userId: json['userId'],
      studentName: json['studentName'],
      description: json['description'],
      severity: json['severity'],
      dateTime: json['date'],
    );
  }
}
