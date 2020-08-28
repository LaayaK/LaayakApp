import 'package:flutter/material.dart';
import 'package:timetable/screens/announcements.dart';
import 'package:timetable/screens/todayClassesPage.dart';
import 'package:timetable/screens/details.dart';
class StudentPage extends StatefulWidget {

  StudentPage({this.code});

  final String code;

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        currentIndex: _page,
        onTap: (int index) {
          setState(() {
            _page = index;
          });
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
        ],
      ),
      body:Container(
          child: (_page == 0)
              ? DetailsPage(code:widget.code)
              : (_page == 1)
              ? TodayClassesPage(code:widget.code)
              : AnnouncementsPage(code:widget.code)
      ),
    );
  }
}
