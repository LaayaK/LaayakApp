import 'package:flutter/material.dart';

import 'package:timetable/screens/createCr.dart';
import 'package:timetable/screens/createStudent.dart';
import 'package:timetable/screens/createTeacher.dart';

//Authentication
import 'package:timetable/services/authentication.dart';

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
//  CodeStatus codeStatus = CodeStatus.NOT_DEFINED;
//  String code = '';
//  bool wrongCode = false;
//  TextEditingController codeController = new TextEditingController();
//  var data;
//
//  void getCode() async {
//    print('getting code from SP');
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    code = (prefs.getString('code') ?? '');
//    print('code got from SP : $code');
//    if (code.isNotEmpty)
//      data = await Firestore.instance.collection('classes')
//        .document(code).get();
//    setState(() {
//      if (code.isNotEmpty)
//        codeStatus = CodeStatus.CODE_PRESENT;
//      else
//        codeStatus = CodeStatus.NO_CODE;
//    });
//  }
//
//  void verifyCode(String codeGot) async {
//    print(codeGot);
//    await Firestore.instance
//        .collection('classes')
//        .document(codeGot)
//        .get()
//        .then((doc) {
//      if (doc.exists) {
//        code = codeGot;
//      }
//    }).catchError((error) {
//      print('Error in getting document');
//      print('error : $error');
//    });
//    if (code == codeGot) {
//      print('code matched document ID');
//      storeFCMToken(codeGot);
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      prefs.setString('code', codeGot);
//      data = await Firestore.instance
//          .collection('classes')
//          .document(codeGot)
//          .get();
//      setState(() {
//        codeStatus = CodeStatus.CODE_PRESENT;
//      });
//    } else {
//      print('code did not match any document ID');
//      setState(() {
//        codeStatus = CodeStatus.NO_CODE;
//        wrongCode = true;
//        codeController.clear();
//      });
//    }
//  }

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _loginForm = false;

  bool _isLoading = false;

  bool _isButtonDisabled = true;

  // Check if form is valid before perform login or sign up
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isLoading = false;
  }

  void resetForm() {
    if (_formKey.currentState != null)
      _formKey.currentState.reset();
    else
      print('formKey was null');
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    if (_loginForm == true)
      _loginForm = false;
    else
      _loginForm = true;
  }

//  @override
//  initState() {
//    print('Above init state');
//    super.initState();
////    print('Below init state');
////    getCode();
////    print('Below getCode');
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
//        (codeStatus == CodeStatus.NOT_DEFINED)
//            ? buildWaitingScreen()
//            : (codeStatus == CodeStatus.NO_CODE)
//                ?
          Container(
        child: ListView(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(0),
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
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
                      child: Image.asset('assets/images/index.jpg')),
//                              Container(
//                                margin: EdgeInsets.symmetric(horizontal: 30),
//                                width: MediaQuery.of(context).size.width,
//                                height: 50,
//                                decoration: BoxDecoration(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(10)),
//                                  color: Colors.grey.shade200,
//                                ),
//                                child: TextField(
//                                  controller: codeController,
//                                  onChanged: (value) {
//                                    if (value.isNotEmpty) {
//                                      setState(() {
//                                        wrongCode = false;
//                                      });
//                                    }
//                                  },
//                                  decoration: InputDecoration(
//                                    border: InputBorder.none,
//                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                                    hintText: 'Enter Code',
//                                    hintStyle: TextStyle(
//                                      fontSize: 15,
//                                      color: Colors.grey
//                                    ),
//                                  ),
//                                ),
//                              ),
                  Visibility(
                    visible: (_loginForm == false),
                    child: loginButtons(context, 'Sign up as Student', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateStudent(
                            auth: widget.auth,
                            loginCallback: widget.loginCallback,
                          ),
                        ),
                      );
                    }),
                  ),
                  Visibility(
                    visible: (_loginForm == false),
                    child: loginButtons(
                      context,
                      'Sign up as C R',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateCr(
                              auth: widget.auth,
                              loginCallback: widget.loginCallback,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: (_loginForm == false),
                    child: loginButtons(
                      context,
                      'Sign up as Teacher',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTeacher(
                              auth: widget.auth,
                              loginCallback: widget.loginCallback,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: (_loginForm == true),
                    child: new Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          showEmailInput(),
                          showPasswordInput(),
                          Builder(
                            builder: (BuildContext context) {
                              return loginButtons(
                                context,
                                'Login',
                                (_isButtonDisabled == true)
                                    ? () {
                                        setState(
                                          () {
                                            _errorMessage =
                                                'Please Enter Valid Email and Password';
                                          },
                                        );
                                        if (_errorMessage.length > 0 &&
                                            _errorMessage != null) {
                                          final snackBar = SnackBar(
                                            content: Text(_errorMessage),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    : () async {
                                        if (validateAndSave()) {
                                          String userId = "";
                                          setState(
                                            () {
                                              _isLoading = true;
                                            },
                                          );
                                          try {
                                            userId = await widget.auth
                                                .signIn(_email, _password);
                                            print('Signed in: $userId');
                                            if (userId.length > 0 &&
                                                userId != null) {
                                              widget.loginCallback();
//                                                Navigator.pop(context);
                                            }
                                          } catch (e) {
                                            print('Error: $e');
                                            setState(
                                              () {
                                                _isLoading = false;
                                                _errorMessage =
                                                    loginErrorCodes(e);
                                                _formKey.currentState.reset();
                                              },
                                            );
                                            if (_errorMessage.length > 0 &&
                                                _errorMessage != null) {
                                              final snackBar = SnackBar(
                                                content: Text(_errorMessage),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        }
                                      },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            toggleFormMode();
                          },
                        );
//                                    print('before set change');
//                                    setState(() {
//                                      codeStatus = CodeStatus.NOT_DEFINED;
//                                    });
//                                    print('before navigation');
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (BuildContext context) =>
//                                                LoginSignUpPage(
//                                                  auth: widget.auth,
//                                                  loginCallback:
//                                                      widget.loginCallback,
//                                                )));
//                                    print('After navigation');
                      },
                      child: Text(
                        (_loginForm == false)
                            ? 'Already registered? Login'
                            : 'Not Registered? Sign Up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontFamily: 'Lobster'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
//                : StudentPage(code: code, data: data));
  }

  Widget showEmailInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFE5E5E5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: 'Enter Email',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFE5E5E5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        onChanged: (value) {
          setState(() {
            _isButtonDisabled = false;
            print('password tapped');
          });
        },
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: 'Enter Password',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }
}
