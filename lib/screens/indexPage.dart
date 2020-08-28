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
  bool wrongCode = true;
  TextEditingController codeController = new TextEditingController();

  void getCode() async {
    print('getting code from SP');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('code') ?? '');
      print('code got from SP : $code');
      if (code.isNotEmpty)
        codeStatus = CodeStatus.CODE_PRESENT;
      else
        codeStatus = CodeStatus.NO_CODE;
    });
  }

  void verifyCode(String code) async {
    print(code);
    await Firestore.instance.collection('classes').document(code).get().then((doc){
      if (doc.exists)
        wrongCode = false;
      else
        wrongCode = true;
      (wrongCode)
          ? print('code matched document ID')
          : print('code did not match any document ID');
    }).catchError((error) {
      print('Error in getting document');
      print('error : $error');
    });
  }

  void printData(String code) async{
    var data = await Firestore.instance.collection('classes').document(code).get();
    print(data['details']['branch']);
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
                    controller: codeController,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          print('code entered is : ${codeController.value.text}');
                          verifyCode(codeController.value.text);
                          if (wrongCode) {
                            setState(() async {
                              code = codeController.value.text;
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('code', code);
                              codeStatus = CodeStatus.CODE_PRESENT;
                            });
                          }
                          else {
                            setState(() {
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