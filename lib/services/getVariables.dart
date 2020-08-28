import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Routes
import 'package:timetable/screens/indexPage.dart';

//Authentication
import 'package:timetable/services/authentication.dart';
import 'package:timetable/screens/loginPage.dart';

class GetVariables extends StatefulWidget {
  const GetVariables(
      {Key key, this.auth, this.logoutCallback, this.userId, this.email})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;

  @override
  _GetVariablesState createState() => _GetVariablesState();
}

class _GetVariablesState extends State<GetVariables> {

  bool isVerified = false;
  String flag = 'NOVALUE';

  void getVerified() async {
    var data = await Firestore.instance
        .collection('student')
        .document(widget.email)
        .get();
  }

  @override
  void initState() {
    super.initState();
    getVerified();
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/logoensvee.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isVerified == false && flag == 'NOVALUE')
      return buildWaitingScreen();
    else if (isVerified == false && flag == widget.email)
      return IndexPage(

      );
    else if (isVerified == true && flag == widget.email)
      return IndexPage(

      );
    return buildWaitingScreen();
  }
}