import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/report.dart';
import '../providers/reports.dart';

class ReportScreen extends StatefulWidget {
  static const routeName = '/report';
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double _currentSliderValue = 3;
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  var _reportData = Report(
    reportId: null,
    userId: null,
    studentName: null,
    description: null,
    severity: null,
    dateTime: null,
  );

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Reports>(
        context,
        listen: false,
      ).addReport(_reportData);
    } catch (error) {
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
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Student Name',
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
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
                        _reportData.severity = value as int;
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
                            //
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
