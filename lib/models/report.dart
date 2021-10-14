import 'package:flutter/material.dart';

class Report {
  String reportId;
  String userName;
  String firstname;
  String lastname;
  String description;
  int severity;
  DateTime dateTime;

  Report({
    required this.reportId,
    required this.userName,
    required this.firstname,
    required this.lastname,
    required this.description,
    required this.severity,
    required this.dateTime,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['id'],
      userName: json['userId'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      description: json['description'],
      severity: json['severity'],
      dateTime: json['date'],
    );
  }
}
