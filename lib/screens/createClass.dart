import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable/services/authentication.dart';
import 'package:timetable/widgets/functions.dart';
import 'package:timetable/widgets/widgets.dart';

class CreateClass extends StatefulWidget {

  CreateClass({this.classId, this.name, this.auth, this.loginCallback});

  final String classId, name;
  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {

  String _college, _branch, _course, _semester;
  TextEditingController _collegeController = new TextEditingController();
  TextEditingController _branchController = new TextEditingController();
  TextEditingController _courseController = new TextEditingController();
  TextEditingController _semesterController = new TextEditingController();

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
              headingText('Welcome ${widget.name}'),
              headingText2('Create your class'),
              showInput('College', _collegeController),
              showInput('Branch', _branchController),
              showInput('Course', _courseController),
              showInput('Semester', _semesterController),
              loginButtons(context, 'Create Class', (){
                _college = _collegeController.value.text;
                _branch = _branchController.value.text;
                _semester = _semesterController.value.text;
                _course = _courseController.value.text;
                if (_college.isNotEmpty && _branch.isNotEmpty && _course.isNotEmpty && _semester.isNotEmpty)
                {
                  try{
                    Firestore.instance.collection('classes').document(widget.classId)
                          .setData({
                        'details' : {
                          'branch' : _branch,
                          'college' : _college,
                          'course' : _course,
                          'crName' : widget.name,
                          'sem' : _semester,
                          'timetable' : 'https://www.softwaresuggest.com/blog/wp-content/uploads/2019/10/Advantages-of-Timetable-Management-System-in-Schools-1.png'
                        }
                      }, merge: true).whenComplete(() {
                        widget.loginCallback();
                        Navigator.pop(context);
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

Widget headingText2(String text) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 30, fontFamily: 'Comfortaa'),
    ),
  );
}
