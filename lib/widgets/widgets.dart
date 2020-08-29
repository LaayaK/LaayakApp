import 'package:flutter/material.dart';
import 'package:timetable/widgets/functions.dart';

// class AddLecture extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => AddLectureState

// ();
// }

// class AddLectureState extends State<AddLecture>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller =
//         AnimationController(vsync: this, duration: Duration

// (milliseconds: 450));
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: 

// Curves.elasticInOut);

//     controller.addListener(() {
//       setState(() {});
//     });

//     controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: ScaleTransition(
//           scale: scaleAnimation,
//           child: Container(
//               margin: EdgeInsets.all(20.0),
//               padding: EdgeInsets.symmetric(vertical: 10.0, 

// horizontal: 10),
//               height: 450.0,
//               decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0))),
//               child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, 

// vertical: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.all

// (Radius.circular(15.0)),
//                   border: Border.all(width: 5, color: Colors.grey)), 

// // dashed Border
//                   child: Column(
//                     children: <Widget>[
//                       Text('Add Lecture',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                             fontSize: 18,
//                           )),
//                        SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 

// 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all

// (Radius.circular(10)),
//                           border: Border.all(color: Colors.grey),
//                           color: Colors.white,
//                         ),
//                         child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'meeting link')),
//                       ),
//                       SizedBox(height: 20),
//                       Row(children: <Widget>[
//                         Text('Start Time',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                             fontSize: 16,
//                           )),
//                         Spacer(),
//                         Text('11:00',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 16,
//                           )),
//                         SizedBox(
//                           width: 50,
//                           child:FlatButton(
//                             padding: EdgeInsets.all(0),
//                         onPressed:(){},
//                           child: Icon(Icons.timer, color: Colors.blue)
//                         ),),
//                       ]),
//                       Row(children: <Widget>[
//                         Text('End Time',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                             fontSize: 16,
//                           )),
//                         Spacer(),
//                         Text('12:00',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 16,
//                           )),
//                         SizedBox(
//                           width: 50,
//                           child:FlatButton(
//                             padding: EdgeInsets.all(0),
//                         onPressed:(){},
//                           child: Icon(Icons.timer, color: Colors.blue)
//                         ),),
//                       ]), 
//                       SizedBox(height: 20),                      
//                      Container(
//                         padding: EdgeInsets.symmetric(horizontal: 

// 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all

// (Radius.circular(10)),
//                           border: Border.all(color: Colors.grey),
//                           color: Colors.white,
//                         ),
//                         child: TextField(
//                           maxLines: 5,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Additional Information')),
//                       ),
//                        Container(
//                                   margin: EdgeInsets.all(10),
//                                   height: 40,
//                                   width: MediaQuery.of

// (context).size.width,
//                                   child: FloatingActionButton.extended(
//                                 onPressed:(){},
//                                 label: Text('Add Lecture'),
//                                   icon: Icon(Icons.check_circle_outline),
//                                     elevation: 1,
//                                 ),),
//                     ],
//                   ))),
//         ),
//       ),
//     );
//   }
// }

Widget SubjectCR(){
return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(0),
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 0.4),
                    blurRadius: 3,
                    color: Colors.grey.shade300,
                  )
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 10, 

vertical: 10),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddLecture(),
                  );
                },
                child: Column(children: <Widget>[
                  Row(
                      crossAxisAlignment: 

CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 

2),
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
                                mainAxisAlignment: 

MainAxisAlignment.start,
                                crossAxisAlignment: 

CrossAxisAlignment.start,
                                children: <Widget>[
                              Text('Digital Design',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                              SizedBox(height: 2),
                              Text('by Prof. Rajesh Rohilla',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  )),
                            ])),
                      ]),
                ]),
              ),
            )
}


Widget buildWaitingScreen() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      alignment: Alignment.center,
      child: Text('LINK AAYA KYA???'),
    ),
  );
}

Widget lectureCard(BuildContext context, dynamic data) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//    height: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow:[
        BoxShadow(
        offset: Offset(0.0,0.4),
        blurRadius: 3,
        color: Colors.grey.shade300,
        )
      ],
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(children: <Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          height: 80,
          width: 45,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data['startTime'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
                Text('|',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
                Text(data['endTime'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
              ]),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
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
              Text(data['subject'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              SizedBox(height: 2),
              Text('by ${data['teacher']}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
              SizedBox(height: 7),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 170) / 3,
                      height: 30,
                      decoration: BoxDecoration(),
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => details(context, data),
                          child: Text('DETAILS',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: 15,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 150) / 3,
                      height: 30,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            launchUrl(data['link']);
                          },
                          child: Text('JOIN',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: 15,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 170) / 3,
                      height: 30,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            copyText(context, data['link']);
                          },
                          child: Text('COPY',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                  ]),
            ])),
      ]),
    ]),
  );
}

Widget lectureDetails(BuildContext context, dynamic data) {
  return new Container(
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15), topLeft: Radius.circular(15)),
    ),
    height: 300,
    child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 40,
        color: Colors.grey.shade300,
        child: Center(
          child: Text('Lecture details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: 1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(data['subject'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Text('by ${data['teacher']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 35,
                        width: 120,
                        child: FloatingActionButton.extended(
                          onPressed: () {},
                          label: Text('Set Alarm'),
                          icon: Icon(Icons.timer),
                          elevation: 1,
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Additional Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(data['desc'],
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black,
                                fontSize: 14,
                              )))
                    ],
                  ),
                ),
              );
            }),
      )
    ]),
  );
}
