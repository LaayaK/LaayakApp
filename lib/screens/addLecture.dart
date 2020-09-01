import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/widgets/widgets.dart';

class AddLecturePage extends StatefulWidget {

  AddLecturePage({this.code});

  final String code;

  @override
  _AddLecturePageState createState() => _AddLecturePageState();
}

class _AddLecturePageState extends State<AddLecturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            headingText('Add Lecture'),
            FutureBuilder(
              future: Firestore.instance.collection('classes').document(widget.code).get(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(),);
                return _buildSubjectList(context, snapshot.data['subjects']);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectList(BuildContext context, List<dynamic> snapshot) {
    return ListView.builder(
        itemCount: (snapshot != null) ? snapshot.length : 0,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return subjectCR(context, snapshot[index], widget.code);
        }
    );
  }
}