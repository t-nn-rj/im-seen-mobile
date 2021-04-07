import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ReportScreen extends StatefulWidget {
  static const routeName = '/report';
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double _currentSliderValue = 3;
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
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
                        //
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
                        //
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
