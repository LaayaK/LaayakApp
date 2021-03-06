import 'package:flutter/material.dart';
import 'package:timetable/screens/createClass.dart';
import 'package:timetable/widgets/functions.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:timetable/services/authentication.dart';

class CreateCr extends StatefulWidget {
  CreateCr({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _CreateCrState createState() => _CreateCrState();
}

class _CreateCrState extends State<CreateCr> {
  String _name, _email, _password, _rollNo;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _rollNoController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F2F3),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            headingText('Class Representative'),
            showInput('Name', _nameController),
            showInput('Roll No.', _rollNoController),
            showInput('Email', _emailController),
            showInput('Password', _passwordController),
            loginButtons(
              context,
              'Sign Up',
              () {
                _name = _nameController.value.text;
                _rollNo = _rollNoController.value.text;
                _email = _emailController.value.text;
                _password = _passwordController.value.text;
                if (_name.isNotEmpty &&
                    _rollNo.isNotEmpty &&
                    _email.isNotEmpty &&
                    _password.isNotEmpty) {
                  try {
                    widget.auth
                        .signUpWithDisplayName(_email, _password, 'cr')
                        .whenComplete(
                      () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateClass(
                              auth: widget.auth,
                              loginCallback: widget.loginCallback,
                              name: _name,
                              rollNo: _rollNo,
                              email: _email,
                            ),
                          ),
                        );
                      },
                    );
                  } catch (err) {
                    print(err);
                    setState(
                      () {
                        _errorMessage = loginErrorCodes(err);
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
