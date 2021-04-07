import 'package:flutter/material.dart';

import 'screens/report_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentalAlert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: AuthScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        ReportScreen.routeName: (ctx) => ReportScreen(),
      },
    );
  }
}
