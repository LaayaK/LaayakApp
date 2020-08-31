import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void details (BuildContext context, dynamic data) {
  showModalBottomSheet(context: context, builder: (context){
    return lectureDetails(context, data);
  });
}

void launchUrl(String url) {
  launch(url);
}

void copyText(BuildContext context, String text)
{
  Clipboard.setData(new ClipboardData(text: text));
  Scaffold.of(context).showSnackBar(SnackBar
    (content: Text('Link Copied')));
}

void addLectureLinkFirestore(String code, Map<String, dynamic> lecture)
{
  Firestore.instance
    .collection('classes')
    .document('$code/lectures/lecturesToday')
    .setData({
      'lectures': FieldValue.arrayUnion([lecture])
    }, merge: true);
}

void addAnnouncementFirestore(String code, Map<String, dynamic> announcement){
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .setData({
    'announcements': FieldValue.arrayUnion([announcement])
  }, merge: true);
}

String getTime(Timestamp timestamp)
{
  String time = '';
  if (timestamp.toDate().hour < 10)
    time += '0${timestamp.toDate().hour.toString()}';
  else
    time += timestamp.toDate().hour.toString();
  time += ' : ';
  if (timestamp.toDate().minute < 10)
    time += '0${timestamp.toDate().minute.toString()}';
  else
    time += timestamp.toDate().minute.toString();
  return time;
}

String getDate(Timestamp timestamp)
{
  String date = '';
  if (timestamp.toDate().day < 10)
    date += '0${timestamp.toDate().day.toString()}';
  else
    date += timestamp.toDate().day.toString();
  date += ' / ';
  if (timestamp.toDate().month < 10)
    date += '0${timestamp.toDate().month.toString()}';
  else
    date += timestamp.toDate().month.toString();
  date += ' / ${timestamp.toDate().year.toString()}';
  return date;
}