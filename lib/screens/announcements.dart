import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/widgets/widgets.dart';

class AnnouncementsPage extends StatefulWidget {
  AnnouncementsPage({this.code, this.user});

  final String code, user;

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
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('classes')
                  .doc('${widget.code}/updates/announcements')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return _buildList(
                  context,
                  snapshot.data['announcements'],
                );
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
              context,
              snapshot[snapshot.length - index - 1],
            );
          else if (snapshot[snapshot.length - index - 1]['type'] ==
              'poll') if (widget.user != null)
            return pollCardCR(
              context,
              snapshot[snapshot.length - index - 1],
            );
          else
            return PollCard(
                context: context,
                data: snapshot[snapshot.length - index - 1],
                code: widget.code);
          else if (snapshot[snapshot.length - index - 1]['type'] == 'link')
            return linkCard(
              context,
              snapshot[snapshot.length - index - 1],
            );
          return Container();
        });
  }
}
