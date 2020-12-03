import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable/widgets/functions.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:timetable/services/authentication.dart';

class CreateTeacher extends StatefulWidget {

  CreateTeacher({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _CreateTeacherState createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {

  String _college, _email, _name, _password;
  TextEditingController _collegeController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(            
            children: <Widget>[
              SizedBox(height: 10),
              headingText('Teacher'),         
              showInput('Name', _nameController),
              showInput('College', _collegeController),
              showInput('Email', _emailController),
              showInput('Password', _passwordController),
              loginButtons(context, 'Create Class', (){
                _college = _collegeController.value.text;
                _name = _nameController.value.text;
                _email = _emailController.value.text;
                _password = _passwordController.value.text;
                if (_college.isNotEmpty && _name.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty)
                {
                  try{
                    widget.auth.signUpWithDisplayName(_email, _password, 'teacher').whenComplete(() {
                      Firestore.instance.collection('teachers').document(_email)
                          .setData({
                        'details' : {
                          'college' : _college,
                          'name' : _name,
                          'email' : _email,
                        }
                      }, merge: true).whenComplete(() {
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
