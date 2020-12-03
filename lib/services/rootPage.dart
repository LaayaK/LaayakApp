import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetable/screens/crPage.dart';
import 'package:timetable/screens/homePage.dart';
import 'package:timetable/screens/indexPage.dart';
import 'package:timetable/screens/studentPage.dart';
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
  String _userId = '', _email = '', _userType = '', _code = '';
  dynamic _data;

  @override
  void initState() {
    super.initState();
    loginCallback();
  }

  void determineUserCode(FirebaseUser user) async {
    await Firestore.instance.collection('classes').document(_code).get().then((data) {
      if (data.exists) {
        setState(() {
          _userId = user.uid;
          _email = user.email;
          _userType = user.displayName;
          _data = data;
          authStatus = AuthStatus.LOGGED_IN;
        });
      } else {
        print('Could not find the class $_code');
        setState(() {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        });
      }
    });
  }

  void loginCallback() {
    authStatus = AuthStatus.NOT_DETERMINED;
    widget.auth.getCurrentUser().then((user) async {
      if (user != null) {
        print('user is not null');
        if (user.displayName == 'cr') {
          print('user is cr');
          await Firestore.instance.collection('cr').document(user.email).get().then((data){
            _code = data['classId'];
          }).whenComplete(() {
            determineUserCode(user);
          });
        } else if (user.displayName == 'student') {
          print('user is student');
          await Firestore.instance.collection('students').document(user.email).get().then((data){
            _code = data['classCode'];
          }).whenComplete(() {
            determineUserCode(user);
          });
        } else if (user.displayName == 'teacher') {
          print('user is a teacher');
          setState(() {
            _userId = user.uid;
            _email = user.email;
            _userType = user.displayName;
            authStatus = AuthStatus.LOGGED_IN;
          });
        } else {
          print('No user got!');
          setState(() {
            authStatus = AuthStatus.NOT_LOGGED_IN;
            print(authStatus.toString());
          });
        }
      } else {
        print('user is null');
        setState(() {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        });
      }
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
          if (_userType == 'teacher') {
            return HomePage(
                userId: _userId,
                auth: widget.auth,
                logoutCallback: logoutCallback,
                email: _email,
            );
          } else if (_userType == 'cr') {
            return CRPage(
                userId: _userId,
                auth: widget.auth,
                logoutCallback: logoutCallback,
                email: _email,
                code: _code,
                data: _data
            );
          } else if (_userType == 'student') {
            return StudentPage(
                userId: _userId,
                auth: widget.auth,
                logoutCallback: logoutCallback,
                email: _email,
                code: _code,
                data: _data
            );
          } else
            return buildWaitingScreen();
        }
        break;
      default:
        return buildWaitingScreen();
    }
    return buildWaitingScreen();
  }
}
