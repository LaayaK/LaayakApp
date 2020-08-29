import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/main.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({this.code});

  final String code;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
          ),
          DefaultTabController(
            length: 2,
            child: Container(
              height: MediaQuery.of(context).size.height - 250,
              //             color: Colors.grey,
              child: Column(
                children: <Widget>[
                  TabBar(tabs: <Widget>[
                    Tab(
                      child: Icon(Icons.person, color: Colors.blue),
                    ),
                    Tab(
                      child: Icon(Icons.book, color: Colors.blue),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text('Logout'),
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('code', '');
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp()),
                                      (route) => false);
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              for (int i = 0; i < 3; i++)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.transparent,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2),
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
                                            height: 35,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Digital Design',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    )),
                                                SizedBox(height: 2),
                                                Text(
                                                  'by Prof. Rajesh Rohilla',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //             )
        ],
      ),
    );
  }
}
