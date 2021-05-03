import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/reports.dart';
import 'screens/report_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MentalAlert());
}

class MentalAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // provider for Reports data
        ChangeNotifierProvider(
          create: (_) => Reports(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
