import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetable/services/notification.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:android_alarm_manager/android_alarm_manager.dart';

void details (BuildContext context, dynamic data) {
  showModalBottomSheet(context: context, builder: (context){
    return SetAlarm(context:context, data:data);
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

void addLinkFirestore(String code, Map<String, dynamic> link)
{
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .setData({
    'announcements': FieldValue.arrayUnion([link])
  }, merge: true);
}

void addPollFirestore(String code, Map<String, dynamic> poll){
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .setData({
    'announcements': FieldValue.arrayUnion([poll])
  }, merge: true);
}

String getTime(DateTime dateTime)
{
  String time = '';
  if (dateTime.hour < 10)
    time += '0${dateTime.hour.toString()}';
  else
    time += dateTime.hour.toString();
  time += ' : ';
  if (dateTime.minute < 10)
    time += '0${dateTime.minute.toString()}';
  else
    time += dateTime.minute.toString();
  return time;
}

String getDate(DateTime dateTime)
{
  String date = '';
  if (dateTime.day < 10)
    date += '0${dateTime.day.toString()}';
  else
    date += dateTime.day.toString();
  date += ' / ';
  if (dateTime.month < 10)
    date += '0${dateTime.month.toString()}';
  else
    date += dateTime.month.toString();
  date += ' / ${dateTime.year.toString()}';
  return date;
}