import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/screens/studentPage.dart';

//Authentication
import 'package:timetable/services/authentication.dart';

import 'package:timetable/screens/loginPage.dart';
import 'package:timetable/widgets/widgets.dart';

enum CodeStatus{
  NOT_DEFINED,
  CODE_PRESENT,
  NO_CODE
}

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  CodeStatus codeStatus = CodeStatus.NOT_DEFINED;
  String code = '';
  bool wrongCode = false;
  TextEditingController codeController = new TextEditingController();

  void getCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    code = (prefs.getString('code') ?? '');
    if (code.isNotEmpty)
      codeStatus = CodeStatus.CODE_PRESENT;
    else
      codeStatus = CodeStatus.NO_CODE;
  }

  bool verifyCode(String code) {
    bool verified = false;
    var docRef = Firestore.instance.collection('classes').document(code);
    docRef.get().then((doc){
      if (doc.exists)
        verified = true;
      else
        verified = false;
    });
    return verified;
  }

  @override
  initState(){
    super.initState();
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (codeStatus == CodeStatus.NOT_DEFINED)
        ? buildWaitingScreen()
        : (codeStatus == CodeStatus.NO_CODE)
          ? Container (
              child: Column(
                children: <Widget>[
                  Text('LINK AAYA KYA?'),
                  TextField(
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (verifyCode(codeController.value.text)) {
                            setState(() async {
                              code = codeController.value.text;
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('code', code);
                            });
                          }
                          else {
                            setState(() {
                              wrongCode = true;
                              codeController.clear();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: wrongCode,
                    child: Text('Wrong Code Entered')
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Text('If you are a CR'),
                      RaisedButton(
                        child: Text('Login Here'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  LoginSignUpPage(auth:widget.auth, loginCallback: widget.loginCallback,)
                              )
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : StudentPage(code: code)
    );
  }
}