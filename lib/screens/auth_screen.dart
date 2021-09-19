import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

enum AuthMode { Signup, Login }

/* This class renders the authentication page
*/
class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 255, 14, 1).withOpacity(0.5),
                  Color.fromRGBO(0, 241, 255, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Mental Alert',
                        style: TextStyle(
                          color:
                              Theme.of(context).accentTextTheme.headline6.color,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.height > 600 ? 3 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* This class renders the login and sign up form
*/
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  String _firstname, _lastname, _email, _phone, _jobTitle, _password;
  Future<Map<String, dynamic>> authMessage;

  final _passwordController = TextEditingController();

  // for switching between login and signup
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    // for show error message
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Try again'),
            ),
          ],
        ),
      );
    }

    var doAuth = () async {
      final form = _formKey.currentState;
      // validates form before proceeding
      if (form.validate()) {
        form.save();

        if (_authMode == AuthMode.Login) {
          // log in
          // calls login in auth provider
          authMessage = auth.login(_email, _password);

          authMessage.then((response) {
            if (response['status']) {
              User user = response['user'];
              Provider.of<UserProvider>(context, listen: false).setUser(user);
              Navigator.of(context).pushReplacementNamed('/report');
            } else {
              String error = response['message'];
              _showErrorDialog(error);
            }
          });
        } else {
          // sign up
          // calls signup in auth provider
          authMessage = auth.signup(
              _firstname, _lastname, _email, _phone, _jobTitle, _password);

          authMessage.then((response) {
            if (response['status']) {
              //User user = response['user'];
              //Provider.of<UserProvider>(context, listen: false).setUser(user);
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Registration successful!'),
                  content: Text(
                      'Please sign in using your registered email and password'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/auth');
                      },
                      child: Text('Log in'),
                    ),
                  ],
                ),
              );
              //Navigator.of(context).pushReplacementNamed('/report');
            } else {
              String error = response['message'];
              _showErrorDialog(error);
            }
          });
        }
      } else {
        _showErrorDialog('Some information is invalid.');
      }
    };

    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup) ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First name'),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstname = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last name'),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lastname = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Job title'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your job title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jobTitle = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phone = value;
                    },
                  ),
                ],
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 3) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: authMessage,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Column(
                        children: [
                          ElevatedButton(
                            child: Text(_authMode == AuthMode.Login
                                ? 'LOGIN'
                                : 'SIGN UP'),
                            onPressed: doAuth,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              primary: Theme.of(context).primaryColor,
                              onPrimary: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .color,
                            ),
                          ),
                          TextButton(
                            child: Text(
                                '${_authMode == AuthMode.Login ? 'Create an account' : 'Have an acount? LOGIN'}'),
                            onPressed: () {
                              // reset form fields
                              _formKey.currentState.reset();
                              _switchAuthMode();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 4),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              primary: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
