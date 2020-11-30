import 'package:HubboxVpnApp/screen/boxes/Boxes.dart';
import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'package:HubboxVpnApp/main.dart';
import 'package:HubboxVpnApp/screen/home/HomePage.dart';
import 'package:HubboxVpnApp/screen/vpn/Vpn.dart';

import '../auth.dart';
import 'login/loginPage.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fitWidth, image: AssetImage('assets/images/site-logo-tr.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {Navigator.of(context).pushReplacementNamed(HomePage.tag)},
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('M2M'),
            onTap: () => {Navigator.of(context).pushReplacementNamed(Vpn.tag)},
          ),
          // ListTile(
          //   leading: Icon(Icons.device_hub),
          //   title: Text('Devices'),
          //   onTap: () => {Navigator.of(context).pushReplacementNamed(Boxes.tag)},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              BetterFeedback.of(context).show();
            },
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginPage.tag);
              MyApp.logout();
            },
          ),
        ],
      ),
    );
  }
}
