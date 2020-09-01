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
  String _rePassword;
  String _errorMessage;

  bool _isLoginForm = true;
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

  void checkFCMToken() async {
    var document = await Firestore.instance
        .collection('student')
        .document(_email)
        .collection('studentInformation')
        .document('privateData')
        .get();
    String token = document['FCMToken'];
    _firebaseMessaging.getToken().then((deviceToken) {
      print('Device Token : $deviceToken');
      if (token != deviceToken) storeFCMToken();
    });
  }

  void storeFCMToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('Device Token : $deviceToken');
      Firestore.instance
          .collection('student')
          .document(_email)
          .collection('studentInformation')
          .document('privateData')
          .setData({
        'FCMToken': deviceToken,
      });
    });
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
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
              Visibility(
                visible: !_isLoginForm,
                child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Already have an Account? Login Here',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Color(0xFF4A90E2),
                        ),
                      ),
                    ),
                    onPressed: () {
                      toggleFormMode();
                      _isButtonDisabled = true;
                      _loginCreateAccText = 'Login';
                    }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(3, 20, 0, 10),
                child: Text(
                  'Email ID',
                  style: TextStyle(fontSize: 16, color: Color(0xFF9E9EA7)),
                ),
              ),
              showEmailInput(),
              Padding(
                padding: (_isLoginForm)
                    ? EdgeInsets.fromLTRB(3, 20, 0, 0)
                    : EdgeInsets.fromLTRB(3, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 16, color: Color(0xFF9E9EA7)),
                    ),
//                    Visibility(
//                      visible: _isLoginForm,
//                      child: FlatButton(
//                        padding: EdgeInsets.all(0),
//                        onPressed: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      ForgotPasswordPage(auth: widget.auth)));
//                        },
//                        child: Text(
//                          'Forgot Password?',
//                          style:
//                          TextStyle(
//                            fontSize: 16,
//                            color: Color(0xFF4A90E2),
//                            decoration: TextDecoration.underline,
//                          ),
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
              showPasswordInput(),
              Visibility(
                visible: !_isLoginForm,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(3, 20, 0, 10),
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(fontSize: 16, color: Color(0xFF9E9EA7)),
                  ),
                ),
              ),
              Visibility(visible: !_isLoginForm, child: showRePasswordInput()),
              SizedBox(height: 20),
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                            if (_isLoginForm) {
                              userId = await widget.auth
                                  .signIn(_email, _password);
//                            checkFCMToken();
                              print('Signed in: $userId');
                            } else {
//                            if (_password == _rePassword) {
//                              userId = await widget.auth
//                                  .signUp(_email, _password);
//                              createStudentData();
//                              storeFCMToken();
//                              widget.loginCallback();
//
//                              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);

//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          DonePage(
//                                              text: 'Account Created',
//                                              email: _email,
//                                              details: 1)));
//                              print('Signed up user: $userId');
//                            } else {
//                              final snackBar = SnackBar(
//                                content: Text('Passwords do not match'),
//                              );
//                              Scaffold.of(context).showSnackBar(snackBar);
//                            }
                            }
                            setState(() {
                              _isLoading = false;
                            });

                            if (userId.length > 0 &&
                                userId != null &&
                                _isLoginForm) {
                              widget.loginCallback();
                              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                            }
                          } catch (e) {
                            print('Error: $e');
                            setState(() {
                              _isLoading = false;
                              switch (e.code) {
                                case "ERROR_INVALID_EMAIL":
                                  _errorMessage = "Please enter a valid email address.";
                                  break;
                                case "ERROR_WRONG_PASSWORD":
                                  _errorMessage = "Incorrect password entered.";
                                  break;
                                case "ERROR_USER_NOT_FOUND":
                                  _errorMessage = "User with this email doesn't exist.";
                                  break;
                                case "ERROR_USER_DISABLED":
                                  _errorMessage = "User with this email has been disabled.";
                                  break;
                                case "ERROR_TOO_MANY_REQUESTS":
                                  _errorMessage = "Too many requests. Please try again later.";
                                  break;
                                case "ERROR_OPERATION_NOT_ALLOWED":
                                  _errorMessage = "Signing in with Email and Password is not enabled.";
                                  break;
                                case "ERROR_WEAK_PASSWORD":
                                  _errorMessage = "Your password is too weak";
                                  break;
                                case "ERROR_EMAIL_ALREADY_IN_USE":
                                  _errorMessage = "Email is already in use on different account";
                                  break;
                                case "ERROR_INVALID_CREDENTIAL":
                                  _errorMessage = "Your email is invalid";
                                  break;
                                default:
                                  _errorMessage = "An undefined Error happened.";
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

//                    RaisedButton(
//                    elevation: 0.0,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10),
//                    ),
//                    onPressed: (_isButtonDisabled == true)
//                        ? () {
//                      setState(() {
//                        _errorMessage =
//                        'Please Enter Valid Email and Password';
//                      });
//                      if (_errorMessage.length > 0 &&
//                          _errorMessage != null) {
//                        final snackBar = SnackBar(
//                          content: Text(_errorMessage),
//                        );
//                        Scaffold.of(context).showSnackBar(snackBar);
//                      }
//                    }
//                        : () async {
//                      if (validateAndSave()) {
//                        String userId = "";
//                        setState(() {
//                          _isLoading = true;
//                        });
//                        try {
//                          if (_isLoginForm) {
//                            userId = await widget.auth
//                                .signIn(_email, _password);
////                            checkFCMToken();
//                            print('Signed in: $userId');
//                          } else {
////                            if (_password == _rePassword) {
////                              userId = await widget.auth
////                                  .signUp(_email, _password);
////                              createStudentData();
////                              storeFCMToken();
////                              widget.loginCallback();
////
////                              Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
//
////                              Navigator.push(
////                                  context,
////                                  MaterialPageRoute(
////                                      builder: (BuildContext context) =>
////                                          DonePage(
////                                              text: 'Account Created',
////                                              email: _email,
////                                              details: 1)));
////                              print('Signed up user: $userId');
////                            } else {
////                              final snackBar = SnackBar(
////                                content: Text('Passwords do not match'),
////                              );
////                              Scaffold.of(context).showSnackBar(snackBar);
////                            }
//                          }
//                          setState(() {
//                            _isLoading = false;
//                          });
//
//                          if (userId.length > 0 &&
//                              userId != null &&
//                              _isLoginForm) {
//                            widget.loginCallback();
//                            Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
//                          }
//                        } catch (e) {
//                          print('Error: $e');
//                          setState(() {
//                            _isLoading = false;
//                            switch (e.code) {
//                              case "ERROR_INVALID_EMAIL":
//                                _errorMessage = "Please enter a valid email address.";
//                                break;
//                              case "ERROR_WRONG_PASSWORD":
//                                _errorMessage = "Incorrect password entered.";
//                                break;
//                              case "ERROR_USER_NOT_FOUND":
//                                _errorMessage = "User with this email doesn't exist.";
//                                break;
//                              case "ERROR_USER_DISABLED":
//                                _errorMessage = "User with this email has been disabled.";
//                                break;
//                              case "ERROR_TOO_MANY_REQUESTS":
//                                _errorMessage = "Too many requests. Please try again later.";
//                                break;
//                              case "ERROR_OPERATION_NOT_ALLOWED":
//                                _errorMessage = "Signing in with Email and Password is not enabled.";
//                                break;
//                              case "ERROR_WEAK_PASSWORD":
//                                _errorMessage = "Your password is too weak";
//                                break;
//                              case "ERROR_EMAIL_ALREADY_IN_USE":
//                                _errorMessage = "Email is already in use on different account";
//                                break;
//                              case "ERROR_INVALID_CREDENTIAL":
//                                _errorMessage = "Your email is invalid";
//                                break;
//                              default:
//                                _errorMessage = "An undefined Error happened.";
//                            }
//                            _formKey.currentState.reset();
//                          });
//                          if (_errorMessage.length > 0 &&
//                              _errorMessage != null) {
//                            final snackBar = SnackBar(
//                              content: Text(_errorMessage),
//                            );
//                            Scaffold.of(context).showSnackBar(snackBar);
//                          }
//                        }
//                      }
//                    },
//                    textColor: Colors.white,
//                    padding: const EdgeInsets.all(0.0),
//                    child: Container(
//                      width: double.infinity,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
//                        gradient: LinearGradient(
//                            colors: [Color(0xff3BB0EA), Color(0xff44D7B6)]),
//                      ),
//                      padding: EdgeInsets.symmetric(vertical: 15),
//                      child: Text(
//                        _loginCreateAccText,
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold,
//                        ),
//                        textAlign: TextAlign.center,
//                      ),
//                    ),
//                  );
                },
              ),
              Visibility(
                visible: _isLoginForm,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('or',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0x33232D4C),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Visibility(
                visible: _isLoginForm,
                child: RaisedButton(
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: Color(0xFFF1F2F3),
                  onPressed: () {
                    setState(() {
                      toggleFormMode();
                      _isButtonDisabled = true;
                      _loginCreateAccText = 'Create New Account';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xFF44D7B6),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Create New Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                height: 50,
              ),
//              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showEmailInput() {
    return Container(
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

  Widget showRePasswordInput() {
    return Container(
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
        ),
        validator: (value) => (value.isEmpty && value.trim() == _password)
            ? 'Passwords do not match'
            : null,
        onSaved: (value) => _rePassword = value.trim(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFE5E5E5),
      ),
    );
  }
}