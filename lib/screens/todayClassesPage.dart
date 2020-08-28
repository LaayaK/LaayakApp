import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:url_launcher/url_launcher.dart';

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
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance
            .collection('classes')
            .document(widget.code)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return _buildList(context, snapshot.data['lecturesToday']);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<dynamic> snapshot) {
    return ListView.builder(
        itemCount: (snapshot != null) ? snapshot.length : 0,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text(snapshot[index]['time']),
                  title: Text(snapshot[index]['subject']),
                  subtitle: Text(snapshot[index]['teacher']),
                  trailing: Icon(Icons.check_circle),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: null,
                      child: Text(
                        'View Details'
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        String url = snapshot[index]['link'];
                        launch(url);
                      },
                      child: Text('Join'),
                    ),
                    RaisedButton(
                      onPressed: null,
                      child: Text('Copy'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

}