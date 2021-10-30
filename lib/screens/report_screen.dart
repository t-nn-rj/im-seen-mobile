import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../models/report.dart';
import '../providers/reports.dart';
import '../providers/auth.dart';

/* This class renders the report page
*/
class ReportScreen extends StatefulWidget {
  static const routeName = '/report';

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double _currentSliderValue = 3;
  // globalkey for validation
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _reportData = Report(
    reportId: "",
    userName: "",
    firstname: "",
    lastname: "",
    description: "",
    severity: 3,
    dateTime: DateTime.now(),
  );
  Future<Map<String, dynamic>>? reportSubmitted;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    // for show error message
    void _showInfoDialog(
        String title, String content, String buttonText, Function()? func) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              onPressed: func,
              child: Text(buttonText),
            ),
          ],
        ),
      );
    }

    // submits the form data to the server
    Future<void> _saveForm() async {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }
      _form.currentState!.save();

      // calls provider Reports to save report
      // and updates UI accordingly
      reportSubmitted = Provider.of<ReportProvider>(
        context,
        listen: false,
      ).addReport(_reportData);
      reportSubmitted!.then((response) {
        if (response['status']) {
          String title = "Submitted";
          String content = "The report has been submitted successfully.";
          String buttonText = "Okay";
          _form.currentState!.reset();
          Function()? func = () {
            Navigator.of(context).pop();
          };
          _showInfoDialog(title, content, buttonText, func);
        } else if (response['loginAgain']) {
          // fails with refresh token, back to login screen
          String title = "An error occurred!";
          String content = response['message'];
          String buttonText = "Back to login";
          Function()? func = () {
            auth.logout();
            Navigator.of(context).pushReplacementNamed('/auth');
          };
          _showInfoDialog(title, content, buttonText, func);
        } else {
          String title = "An error occurred!";
          String content = response['message'];
          String buttonText = "Okay";
          Function()? func = () {
            Navigator.of(context).pop();
          };
          _showInfoDialog(title, content, buttonText, func);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        actions: [],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text('Student first name'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide the student\'s first name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reportData.firstname = value ?? "";
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Student last name'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide the student\'s last name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reportData.lastname = value ?? "";
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Description'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      maxLines: 10,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide the description.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reportData.description = value ?? "";
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Level of Concern (1-5)',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue.toString(),
                      onChanged: (double value) {
                        _reportData.severity = value.toInt();
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: reportSubmitted,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                child: Text('Submit'),
                                onPressed: () {
                                  _saveForm();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8.0),
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Theme.of(context)
                                      .primaryTextTheme
                                      .button!
                                      .color,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                child: Text('Reset'),
                                onPressed: () {
                                  _form.currentState!.reset();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8.0),
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Theme.of(context)
                                      .primaryTextTheme
                                      .button!
                                      .color,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
