import 'package:flutter/material.dart';

class AnnouncementsPage extends StatefulWidget {

  AnnouncementsPage({this.code});

  final String code;

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class Announcement extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double widthC = MediaQuery.of(context).size.width - 80;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         child: ListView(children: <Widget>[
//           Container(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                 children: <Widget>[
//                 Text(
//                   'Announcements',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(width: 5),
//                 Icon(Icons.speaker_notes)
//               ])),
//           for (int i = 0; i < 5; i++)
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                     bottom: BorderSide(width: 1, color: Colors.grey.shade200)),
//               ),
//               child: Column(children: <Widget>[
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         height: 35,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 10),
//                         height: 55,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                           width: widthC,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Row(children: <Widget>[
//                                   Text('11:00 ',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 13,
//                                       )),
//                                   SizedBox(width: 2),
//                                   Text('1/09/2020',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 13,
//                                       )),
//                                 ]),
//                                 SizedBox(height: 5),
//                                 Text(
//                                     'There will be no class on saturday be no class on saturday There will be no class on saturday There will be no class',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 15,
//                                     )),
//                               ])),
//                     ]),
//               ]),
//             ),
//         ]),
//       ),
//     );
//   }
// }

