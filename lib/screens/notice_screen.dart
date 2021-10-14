import 'package:flutter/material.dart';

// this class renders the notice screen
class NoticeScreen extends StatelessWidget {
  static const routeName = '/notice';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notice',
      home: Scaffold(
        // vertical center
        body: Center(
          child: SingleChildScrollView(
            // for content to be scrollable
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Notice",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 50,
                    fontFamily: 'Anton',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Observations of high risk behavior indicating immediate danger should be directly communicated to school officials in addition to being reported through this app.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Level of Concern Insight",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 30,
                    fontFamily: 'Anton',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Level 1 indicates a mild concern, for example, a student appears to be overly fatigued or disenaged.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Level 3 indicates a moderate concern, for example, a student is visibly upset and expressing their concerns or emotion.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Level 5 indicates a serious concern, for example, a student could be a danger to themselves or others. Level 5 concerns should be reported to the appropriate school official separately from reporting the observation through this app.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/report');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Theme.of(context).primaryTextTheme.button!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
