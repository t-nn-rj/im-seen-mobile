import 'package:flutter/material.dart';

import 'screens/report_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MentalAlert());
}

class MentalAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentalAlert',
      // defines theme for the whole app
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
