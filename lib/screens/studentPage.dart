import 'package:flutter/material.dart';
import 'package:timetable/main.dart';
import 'package:timetable/screens/todayClassesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            SizedBox(height: 100,),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('code', '');
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) => MyApp()), (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
