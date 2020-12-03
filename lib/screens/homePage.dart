import 'package:flutter/material.dart';
import 'package:timetable/screens/teacherPage.dart';
import 'package:timetable/services/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key key,
      this.email,
      this.auth,
      this.userId,
      this.logoutCallback,});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId, email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text('TEACHER PAGE!!! Find classes!'),
              FlatButton(child: Text('Go to Home Page'),
                  onPressed: () {

                // this is the class-> find code and send data and code accordingly

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> TeacherPage(
                          userId: widget.userId,
                          auth: widget.auth,
                          logoutCallback: widget.logoutCallback,
                          email: widget.email,
                      )
                    ));
                  }
              ),
            ],
          ),
        )
    );
  }
}
