import 'package:flutter/material.dart';
import 'package:timetable/screens/todayClassesPage.dart';

class StudentPage extends StatefulWidget {

  StudentPage({this.code});

  final String code;

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: ListView(
          children: <Widget>[
            TodayClassesPage(code:widget.code),
          ],
        ),
      ),
    );
  }
}
