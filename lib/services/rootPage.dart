import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable/screens/homePage.dart';
import 'package:timetable/screens/indexPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/services/authentication.dart';
import 'package:timetable/widgets/widgets.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = '', _email = '', _code = '';

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var listOfCRs = await Firestore.instance.collection('students').document(
          'listOfCRs').get();
      listOfCRs['listOfCRs'].forEach((key, value) {
        print('key : $key');
        print('value : $value');
        setState(() {
          if (user != null) {
            _userId = user?.uid;
            _email = user?.email;
            _code = value;
            prefs.setString('code', _code);
            print('code : $_code');
          }
          authStatus =
          user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
        });
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
//      var listOfCRs = await Firestore.instance.collection('students').document('listOfCRs').get();
//      listOfCRs['listOfCRs'].forEach((key, value){
//        print('key : $key');
//        print('value : $value');
//        if (key == _email)
          setState(() {
            _code = (prefs.getString('code') ?? '');
            _userId = user.uid.toString();
            _email = user.email.toString();
            print('code : $_code');
            authStatus = AuthStatus.LOGGED_IN;
//          });
      });
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = '';
      _email = '';
      _code = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print('Sending to Index Page');
        return new IndexPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          print('Sending to HomePage');
          return HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
            email: _email,
            code: _code,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
