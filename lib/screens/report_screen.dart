import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/report.dart';
import '../providers/reports.dart';

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
  var reports = new Reports();
  var _reportData = Report(
    reportId: null,
    userId: null,
    studentName: null,
    description: null,
    severity: 3,
    dateTime: null,
  );

  // submits the form data to the server
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // shows loading spin
    setState(() {
      _isLoading = true;
    });

    // TODO
    try {
      Future<Report> report = reports.addReport(_reportData);
      // await Provider.of<Reports>(
      //   context,
      //   listen: false,
      // ).addReport(_reportData);
      //print(report);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    // disables loading spin
    setState(() {
      _isLoading = false;
    });
    // informs users reported submitted
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Submitted'),
        content: Text('The report has been submitted.'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
    // Navigator.of(context).pop();

    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   showDialog(
    //     context: context,
    //     builder: (ctx) => AlertDialog(
    //       title: Text('Submitted'),
    //       content: Text('The report has been submitted.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Okay'),
    //           onPressed: () {
    //             Navigator.of(ctx).pop();
    //           },
    //         )
    //       ],
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 25,
                    ),
                    Text('Student Name'),
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
                        if (value.isEmpty) {
                          return 'Please provide the student\'s name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reportData.studentName = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                        if (value.isEmpty) {
                          return 'Please provide the description.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reportData.description = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 30,
                    ),
                    Row(
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
                            onPrimary:
                                Theme.of(context).primaryTextTheme.button.color,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () {
                            // TODO
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            primary: Theme.of(context).primaryColor,
                            onPrimary:
                                Theme.of(context).primaryTextTheme.button.color,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
