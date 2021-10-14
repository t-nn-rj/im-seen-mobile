import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/notice_screen.dart';
import 'screens/report_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/reports.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';
import 'providers/user_preferences.dart';

void main() {
  runApp(MentalAlert());
}

class MentalAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // goes to shared storage and retrieve user data
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        // provider for Reports data
        ChangeNotifierProvider(
          create: (_) => ReportProvider(),
        ), // provider for authentication
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ), // provider for user state
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MentalAlert',
        // defines theme for the whole app
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  // if user auth data found, direct to ReportScreen
                  // else direct to login page
                  if (snapshot.hasError)
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text('Error: ${snapshot.error}'),
                    );
                  else if (snapshot.hasData) {
                    final up = snapshot.data as User;
                    if (up.getToken == "") return AuthScreen();
                  } else {
                    Provider.of<UserProvider>(context)
                        .setUser(snapshot.data as User);
                    return ReportScreen();
                  }
              }
              return AuthScreen();
            }),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          ReportScreen.routeName: (ctx) => ReportScreen(),
          NoticeScreen.routeName: (ctx) => NoticeScreen(),
        },
      ),
    );
  }
}
