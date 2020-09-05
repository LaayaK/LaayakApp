import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/screens/studentPage.dart';

//Authentication
import 'package:timetable/services/authentication.dart';

import 'package:timetable/screens/loginPage.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:timetable/widgets/functions.dart';

enum CodeStatus { NOT_DEFINED, CODE_PRESENT, NO_CODE }

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
  var data;

  void getCode() async {
    print('getting code from SP');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    code = (prefs.getString('code') ?? '');
    print('code got from SP : $code');
    if (code.isNotEmpty)
      data = await Firestore.instance.collection('classes')
        .document(code).get();
    setState(() {
      if (code.isNotEmpty)
        codeStatus = CodeStatus.CODE_PRESENT;
      else
        codeStatus = CodeStatus.NO_CODE;
    });
  }

  void verifyCode(String codeGot) async {
    print(codeGot);
    await Firestore.instance
        .collection('classes')
        .document(codeGot)
        .get()
        .then((doc) {
      if (doc.exists) {
        code = codeGot;
      }
    }).catchError((error) {
      print('Error in getting document');
      print('error : $error');
    });
    if (code == codeGot) {
      print('code matched document ID');
      storeFCMToken(codeGot);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('code', codeGot);
      data = await Firestore.instance
          .collection('classes')
          .document(codeGot)
          .get();
      setState(() {
        codeStatus = CodeStatus.CODE_PRESENT;
      });
    } else {
      print('code did not match any document ID');
      setState(() {
        codeStatus = CodeStatus.NO_CODE;
        wrongCode = true;
        codeController.clear();
      });
    }
  }

  @override
  initState() {
    print('Above init state');
    super.initState();
    print('Below init state');
    getCode();
    print('Below getCode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (codeStatus == CodeStatus.NOT_DEFINED)
            ? buildWaitingScreen()
            : (codeStatus == CodeStatus.NO_CODE)
                ? Container(
                    child: ListView(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 50,),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            padding: EdgeInsets.all(0),
                            color: Colors.transparent,
                            child: Column(children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    height: 45,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 85,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.green,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Link Aaya \nKya?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  height: 240,
                                  child:
                                      Image.asset('assets/images/index.jpg')),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey.shade200,
                                ),
                                child: TextField(
                                  controller: codeController,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        wrongCode = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    hintText: 'Enter Code',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.pinkAccent),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'Lobster'
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      codeStatus = CodeStatus.NOT_DEFINED;
                                    });
                                    verifyCode(codeController.value.text);
                                  },
                                ),
                              ),
                              Visibility(
                                  visible: wrongCode,
                                  child: Text('Wrong Code Entered',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontFamily: 'Lobster'
                                      ))),
                              SizedBox(
                                  height: 50),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: FlatButton(
                                  onPressed: () {
                                    print('before set change');
                                    setState(() {
                                      codeStatus = CodeStatus.NOT_DEFINED;
                                    });
                                    print('before navigation');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginSignUpPage(
                                                  auth: widget.auth,
                                                  loginCallback:
                                                      widget.loginCallback,
                                                )));
                                    print('After navigation');
                                  },
                                  child: Text(
                                    'Login as Class Representative',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontFamily: 'Lobster'
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ]),
                  )
                : StudentPage(code: code, data: data));
  }
}
