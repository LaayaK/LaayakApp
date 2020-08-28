import 'package:flutter/material.dart';
import 'package:timetable/screens/todayClassesPage.dart';

import 'package:timetable/services/authentication.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.email, this.auth, this.userId, this.logoutCallback});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: ListView(
          children: <Widget>[
            Text('Logged in : ${widget.email}'),
            TodayClassesPage(),
          ],
        ),
      ),
    );
  }
}
