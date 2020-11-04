import 'package:flutter/material.dart';

import '../LeftMenu.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.fill,
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Hubbox',
        style: TextStyle(fontSize: 28.0, color: Colors.black54),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '',
        style: TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    final body = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),

//      decoration: BoxDecoration(
//        gradient: LinearGradient(colors: [
//          Colors.blue,
//          Colors.lightBlueAccent,
//        ]),
//      ),
      child: Column(
        children: <Widget>[alucard, welcome, lorem],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: NavDrawer(),
      body: body,
    );
  }
}
