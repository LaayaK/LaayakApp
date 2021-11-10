import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SetAlarm extends StatefulWidget {
  SetAlarm({this.context, this.data});

  final BuildContext context;
  final data;

  @override
  _SetAlarmState createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      height: 300,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 40,
            color: Colors.grey.shade300,
            child: Center(
              child: Text(
                'Lecture details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
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
                        Text(widget.data['subject'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        Text('by ${widget.data['teacher']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 35,
//                          width: 120,
                          child: FloatingActionButton.extended(
                            onPressed: null,
                            label: Text('Set Notification'),
                            icon: Icon(Icons.notifications_active),
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
                            child: Text(widget.data['text'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                )))
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
