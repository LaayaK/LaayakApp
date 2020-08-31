import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/main.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({this.code, this.user, this.logoutCallback, this.auth});

  final String code, user;
  final logoutCallback, auth;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                title: Text(
                  'Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.network(
                  'https://cdn.pixabay.com/photo/2020/05/13/17/38/foliage-5168308__340.jpg',
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
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(0),
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.blue),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (widget.user != null)
                                  {
                                    print('logging out');
                                    await widget.auth.signOut();
                                    widget.logoutCallback();
                                  }
                                  print('clearing SP');
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  prefs.setString('code', '');
                                  Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                                },
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delhi Technological University',
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Btech ECE ',
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '3 Semester',
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
                                        text: 'Himanshu Gill',
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'Group CR : ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Himanshu Gill',
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
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  for (int i = 0; i < 6; i++)
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Digital Design',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                    SizedBox(height: 2),
                                    Text(
                                      'by Prof. Rajesh Rohilla',
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
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.add,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
