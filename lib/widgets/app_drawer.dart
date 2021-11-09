import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

/* This class renders the drawer which shows up from the left
 */
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello ${user.email}'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('Submit a Report'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/report');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Notice'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/notice');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              //Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/auth');
            },
          ),
        ],
      ),
    );
  }
}
