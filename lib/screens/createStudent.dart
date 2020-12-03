import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable/services/authentication.dart';
import 'package:timetable/widgets/functions.dart';
import 'package:timetable/widgets/widgets.dart';

class CreateStudent extends StatefulWidget {

  CreateStudent({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _CreateStudentState createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {

  String _name, _email, _password, _rollNo, _classCode;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _rollNoController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _classCodeController = new TextEditingController();

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
              headingText('Student'),
              showInput('Class Code', _classCodeController),
              showInput('Name', _nameController),
              showInput('Roll No.', _rollNoController),
              showInput('Email', _emailController),
              showInput('Password', _passwordController),
              loginButtons(context, 'Sign Up', (){
                _classCode = _classCodeController.value.text;
                _name = _nameController.value.text;
                _rollNo = _rollNoController.value.text;
                _email = _emailController.value.text;
                _password = _passwordController.value.text;
                if (_classCode.isNotEmpty && _name.isNotEmpty && _rollNo.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty)
                {
                  try{
                    widget.auth.signUpWithDisplayName(_email, _password, 'student')
                        .whenComplete(() {
                      Firestore.instance.collection('students').document(_email)
                          .setData({
                        'classCode' : _classCode,
                        'email' : _email,
                        'name' : _name,
                        'rollNo' : _rollNo,
                        'verified' : false
                      }).whenComplete(() {
                        Firestore.instance.collection('classes/$_classCode/details').document('stuList')
                            .updateData({
                          'studentsList' : FieldValue.arrayUnion([{
                            'email': _email,
                            'name' : _name,
                            'rollNo' : _rollNo
                          }]),
                        });
                      }).whenComplete(() {
                        widget.loginCallback();
                        Navigator.pop(context);
                      });
                    });
                  } catch(err) {
                    print(err);
                    setState(() {
                      _errorMessage = loginErrorCodes(err);
                    });
                  }
                }
              }),             
            ],
          ),
      ),
    );
  }
}
