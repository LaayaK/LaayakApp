import 'package:flutter/material.dart';
import 'package:timetable/screens/addDataPage.dart';
import 'package:timetable/screens/announcements.dart';
import 'package:timetable/screens/details.dart';
import 'package:timetable/screens/todayClassesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/services/authentication.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.email, this.auth, this.userId, this.logoutCallback, this.code});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;
  final String code;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        currentIndex: _page,
        onTap: (int index) async {
//          if (_page == 3)
//          {
//            widget.logoutCallback();
//            SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setString('code', '');
//
////            Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
//          }
//          else {
            setState(() {
              _page = index;
            });
//          }
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add, size: 27, color: Colors.blue),
            icon: Icon(Icons.add, size: 27, color: Colors.grey),
            title: Container(),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, size: 27, color: Colors.blue),
            icon: Icon(Icons.home, size: 27, color: Colors.grey),
            title: Container(),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.announcement, size: 27, color: Colors.blue),
            icon: Icon(Icons.announcement, size: 27, color: Colors.grey),
            title: Container(),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, size: 27, color: Colors.blue),
            icon: Icon(Icons.person, size: 27, color: Colors.grey),
            title: Container(),
          ),
        ],
      ),
      body:Container(
        child: (_page == 0)
          ? AddDataPage(code:widget.code)
          : (_page == 1)
            ? TodayClassesPage(code:widget.code)
            : (_page == 2)
              ? AnnouncementsPage(code:widget.code)
              : DetailsPage(code: widget.code, user: widget.userId, logoutCallback: widget.logoutCallback, auth: widget.auth,)
      ),
    );
  }
}
