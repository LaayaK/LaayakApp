import 'package:flutter/material.dart';
import 'package:timetable/widgets/functions.dart';

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
    height: 110,
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
