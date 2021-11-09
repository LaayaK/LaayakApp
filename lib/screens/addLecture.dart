import 'package:flutter/material.dart';
import 'package:timetable/widgets/widgets.dart';

class AddLecturePage extends StatefulWidget {
  AddLecturePage({this.code, this.subjects});

  final String code;
  final subjects;

  @override
  _AddLecturePageState createState() => _AddLecturePageState();
}

class _AddLecturePageState extends State<AddLecturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            headingText('Add Lecture'),
            _buildSubjectList(context, widget.subjects)
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
        });
  }
}
