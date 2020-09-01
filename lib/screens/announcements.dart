import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/widgets/widgets.dart';

class AnnouncementsPage extends StatefulWidget {
  AnnouncementsPage({this.code});

  final String code;

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
            headingText('Announcemnts'),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection('classes')
                    .document('${widget.code}/updates/announcements')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return _buildList(context, snapshot.data['announcements']);
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
          if (snapshot[snapshot.length - index - 1]['type'] == 'announcement')
            return announcementCard(
                context, snapshot[snapshot.length - index - 1]);
          else if (snapshot[snapshot.length - index - 1]['type'] == 'poll')
            return pollCard(
                context, snapshot[snapshot.length - index - 1]);
          else if (snapshot[snapshot.length - index - 1]['type'] == 'link')
            return linkCard(
                context, snapshot[snapshot.length - index - 1]);
          return Container();
        });
  }
}
