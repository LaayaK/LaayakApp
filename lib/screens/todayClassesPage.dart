import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:timetable/widgets/functions.dart';

class TodayClassesPage extends StatefulWidget {
  TodayClassesPage({this.code});

  final String code;

  @override
  _TodayClassesPageState createState() => _TodayClassesPageState();
}

class _TodayClassesPageState extends State<TodayClassesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          headingText('Lectures Today'),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('classes')
                  .document('${widget.code}/lectures/lecturesToday')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return _buildList(context, snapshot.data['lectures']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<dynamic> snapshot) {
    return ListView.builder(
        itemCount: (snapshot != null) ? snapshot.length : 0,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return lectureCard(context, snapshot[index]);
        });
  }
}
