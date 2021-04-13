import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* This class renders the drawer which shows up from the left
 */
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello [User]!'),
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
            leading: Icon(Icons.help),
            title: Text('Tutorials'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('User Agreement'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
