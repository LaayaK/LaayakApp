import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

String getPollKey(DateTime dateTime)
{
  String key = '${dateTime.millisecondsSinceEpoch}';
  return key;
}

void pollTap(BuildContext context, String code, dynamic data, bool response) async {
  String text;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (response)
  {
    prefs.setString(getPollKey(data['dateAndTime'].toDate()), data['yesOption']);
    text = data['yesOption'];
    data['yesCount']++;
  }
  else
  {
    prefs.setString(getPollKey(data['dateAndTime'].toDate()), data['noOption']);
    text = data['noOption'];
    data['noCount']++;
  }
  var docData = await Firestore.instance.collection('classes')
      .document('$code/updates/announcements').get();
  List<dynamic> announcements = docData.data['announcements'];
  print('announcements set up');
  for (int i = 0; i < announcements.length; i++)
  {
    print(announcements[i]['type']);
    if(announcements[i]['type'] == 'poll'
        && announcements[i]['dateAndTime'] == data['dateAndTime'])
    {
      announcements[i] = data;
      break;
    }
  }
  Firestore.instance.collection('classes')
      .document('$code/updates/announcements')
      .updateData({'announcements': announcements});
  final snackBar = SnackBar(content: Text('You have responded $text successfully'));
  Scaffold.of(context).showSnackBar(snackBar);
}

Future<String> getPollResponse(String key) async {
  String response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  response = prefs.getString(key) ?? '';
  return response;
}