import 'package:flutter/material.dart';

class CreateTeacher extends StatefulWidget {
  @override
  _CreateTeacherState createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
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
              showInput('Name'), 
              showInput('College'), 
              showInput('Email'),
              showPasswordInput(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.pinkAccent),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),             
            ],
          ),
      ),
    );
  }
}
