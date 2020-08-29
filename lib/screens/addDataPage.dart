import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/widgets/widgets.dart';

class AddDataPage extends StatefulWidget {

  AddDataPage({this.code});

  final String code;

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Text('Add Lecture',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          FutureBuilder(
            future: Firestore.instance.collection('classes').document(widget.code).get(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              return _buildSubjectList(context, snapshot.data['subjects']);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectList(BuildContext context, List<dynamic> snapshot) {
    return ListView.builder(
        itemCount: (snapshot != null) ? snapshot.length : 0,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return subjectCR(context, snapshot[index], widget.code);
        }
    );
  }

}



// ListView(
//         children: <Widget>[
// //           Center(
// //             child: 
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text('Add Notification',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold)),
// //             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             padding: EdgeInsets.all(0),
//             height: 70,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   offset: Offset(0.0, 0.4),
//                   blurRadius: 3,
//                   color: Colors.grey.shade300,
//                 )
//               ],
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: FlatButton(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               onPressed: () {
// //                   showDialog(
// //                     context: context,
// //                     builder: (_) => AddLecture(),
// //                   );
//               },
//               child: Column(children: <Widget>[
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Icon(Icons.edit, color: Colors.green, size: 30),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 2),
//                         height: 25,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         height: 45,
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
//                         height: 25,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                             Text('Lecture',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                 )),
//                           ])),
//                     ]),
//               ]),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             padding: EdgeInsets.all(0),
//             height: 70,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   offset: Offset(0.0, 0.4),
//                   blurRadius: 3,
//                   color: Colors.grey.shade300,
//                 )
//               ],
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: FlatButton(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               onPressed: () {
// //                   showDialog(
// //                     context: context,
// //                     builder: (_) => AddLecture(),
// //                   );
//               },
//               child: Column(children: <Widget>[
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Icon(Icons.speaker_notes,
//                             color: Colors.green, size: 30),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 2),
//                         height: 25,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         height: 45,
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
//                         height: 25,
//                         width: 2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: Colors.green,
//                         ),
//                       ),
//                       Container(
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                             Text('Announcement',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                 )),
//                           ])),
//                     ]),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     )
