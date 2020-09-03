import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(
      {this.code,
      this.details,
      this.subjects,
      this.user,
      this.logoutCallback,
      this.auth});

  final String code, user;
  final details, subjects;
  final logoutCallback, auth;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void deleteFCMToken() {
    _firebaseMessaging.getToken().then((deviceToken) async {
      print('Device Token : $deviceToken');
      var data = await Firestore.instance
          .collection('students')
          .document('fcmTokens')
          .get();
      List<dynamic> newTokens = [], fcmTokens = data['fcmTokens'];
      for (int i = 0; i < fcmTokens.length; i++) {
        if (fcmTokens[i] != deviceToken) newTokens.add(fcmTokens[i]);
      }
      Firestore.instance
          .collection('students')
          .document('fcmTokens')
          .updateData({'fcmTokens': newTokens});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsNotScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.blueGrey[900],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Image.asset(
                        'assets/images/${widget.details['timeTable']}.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  indicatorColor: Colors.amber[300],
                  labelColor: Colors.blueGrey[900],
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.blueGrey[500],
                  tabs: [
                    Tab(
                      child: Container(
                        height: double.infinity,
                        //                       padding: EdgeInsets,all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(Icons.person),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: double.infinity,
                        //                       padding: EdgeInsets,all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(Icons.book),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Container(
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  //                   SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Batch Info',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  Container(
//                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: _buildDetails(context),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Developer Info',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Text('himeshnayak015@gmail.com'),
                        Text('sketchharry01@gmail.com'),
                        Text('pscoder10462@gmail.com'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FlatButton(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        deleteFCMToken();
                        SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                        prefs.setString('code', '');
                        if (widget.user != null) {
                          print('logging out');
                          await widget.auth.signOut();
                          widget.logoutCallback();
                        }
                        else
                          Navigator.pushNamedAndRemoveUntil(
                            context, '/main', (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
//              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('My Subjects',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  Container(
//                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: _buildList(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: (widget.subjects != null) ? widget.subjects.length : 0,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(0),
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 25,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 45,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              '${widget.subjects[index]['subjectCode']} : ${widget.subjects[index]['subject']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                          SizedBox(height: 2),
                          Text(
                            'by ${widget.subjects[index]['teacher']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget _buildDetails(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: EdgeInsets.all(0),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 15,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.details['college'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 15,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.details['course']} ${widget.details['branch']} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 15,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Semester : ${widget.details['sem']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 15,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Class CR : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: widget.details['crName'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
