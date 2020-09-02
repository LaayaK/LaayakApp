import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Authentication
import 'package:timetable/services/authentication.dart';

//Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({Key key, this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoading;

  bool _isButtonDisabled = true;

  String _loginCreateAccText = 'Login';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // Check if form is valid before perform login or sign up
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void storeFCMToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('Device Token : $deviceToken');
      Firestore.instance
          .collection('students')
          .document('fcmTokens')
          .setData({
        'fcmTokens': FieldValue.arrayUnion([deviceToken])
      }, merge: true);
    });
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isLoading = false;

  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFFF1F2F3),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                _loginCreateAccText.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color(0xFF0D0C21),
                ),
              ),
              SizedBox(height: 20),
              showEmailInput(),
              showPasswordInput(),
              SizedBox(height: 10),
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: (_isButtonDisabled == true)
                          ? () {
                        setState(() {
                          _errorMessage =
                          'Please Enter Valid Email and Password';
                        });
                        if (_errorMessage.length > 0 &&
                            _errorMessage != null) {
                          final snackBar = SnackBar(
                            content: Text(_errorMessage),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }
                          : () async {
                        if (validateAndSave()) {
                          String userId = "";
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            userId = await widget.auth
                                .signIn(_email, _password);
                            storeFCMToken();

                            print('Signed in: $userId');

                            if (userId.length > 0 &&
                                userId != null) {
                              widget.loginCallback();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/main', (route) => false);
                            }
                          } catch (e) {
                            print('Error: $e');
                            setState(() {
                              _isLoading = false;
                              switch (e.code) {
                                case "ERROR_INVALID_EMAIL":
                                  _errorMessage =
                                  "Please enter a valid email address.";
                                  break;
                                case "ERROR_WRONG_PASSWORD":
                                  _errorMessage = "Incorrect password entered.";
                                  break;
                                case "ERROR_USER_NOT_FOUND":
                                  _errorMessage =
                                  "User with this email doesn't exist.";
                                  break;
                                case "ERROR_USER_DISABLED":
                                  _errorMessage =
                                  "User with this email has been disabled.";
                                  break;
                                case "ERROR_TOO_MANY_REQUESTS":
                                  _errorMessage =
                                  "Too many requests. Please try again later.";
                                  break;
                                case "ERROR_OPERATION_NOT_ALLOWED":
                                  _errorMessage =
                                  "Signing in with Email and Password is not enabled.";
                                  break;
                                case "ERROR_WEAK_PASSWORD":
                                  _errorMessage = "Your password is too weak";
                                  break;
                                case "ERROR_EMAIL_ALREADY_IN_USE":
                                  _errorMessage =
                                  "Email is already in use on different account";
                                  break;
                                case "ERROR_INVALID_CREDENTIAL":
                                  _errorMessage = "Your email is invalid";
                                  break;
                                default:
                                  _errorMessage =
                                  "An undefined Error happened.";
                              }
                              _formKey.currentState.reset();
                            });
                            if (_errorMessage.length > 0 &&
                                _errorMessage != null) {
                              final snackBar = SnackBar(
                                content: Text(_errorMessage),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                    ),
                  );
                }),
            ],
          ),
        ));
  }

  Widget showEmailInput() {
    return Container(
      margin: EdgeInsets.all(10),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: 'Enter Email',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFE5E5E5),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      margin: EdgeInsets.all(10),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: 'Enter Password',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFE5E5E5),
      ),
    );
  }
}