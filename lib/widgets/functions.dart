import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void details(BuildContext context, dynamic data) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return lectureDetails(context, data);
      });
}

void launchUrl(String url) {
  launch(url);
}

void copyText(BuildContext context, String text) {
  Clipboard.setData(new ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Link Copied'),
    ),
  );
}

void addLectureLinkFirestore(String code, Map<String, dynamic> lecture) {
  Firestore.instance
      .collection('classes')
      .document('$code/lectures/lecturesToday')
      .updateData({
    'lectures': FieldValue.arrayUnion([lecture])
  });
}

void addAnnouncementFirestore(String code, Map<String, dynamic> announcement) {
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .updateData(
    {
      'announcements': FieldValue.arrayUnion([announcement])
    },
  );
}

void addLinkFirestore(String code, Map<String, dynamic> link) {
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .updateData({
    'announcements': FieldValue.arrayUnion([link])
  });
}

void addAssignFirestore(String code, Map<String, dynamic> assign) {
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .updateData({
    'assignments': FieldValue.arrayUnion([assign])
  });
}

void addPollFirestore(String code, Map<String, dynamic> poll) {
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .updateData({
    'announcements': FieldValue.arrayUnion([poll])
  });
}

String getTime(DateTime dateTime) {
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

String getDate(DateTime dateTime) {
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

String getPollKey(DateTime dateTime) {
  String key = '${dateTime.millisecondsSinceEpoch}';
  return key;
}

void pollTap(
    BuildContext context, String code, dynamic data, bool response) async {
  String text;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (response) {
    prefs.setString(
        getPollKey(data['dateAndTime'].toDate()), data['yesOption']);
    text = data['yesOption'];
    data['yesCount']++;
  } else {
    prefs.setString(getPollKey(data['dateAndTime'].toDate()), data['noOption']);
    text = data['noOption'];
    data['noCount']++;
  }
  var docData = await Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .get();
  List<dynamic> announcements = docData.data['announcements'];
  print('announcements set up');
  for (int i = 0; i < announcements.length; i++) {
    print(announcements[i]['type']);
    if (announcements[i]['type'] == 'poll' &&
        announcements[i]['dateAndTime'] == data['dateAndTime']) {
      announcements[i] = data;
      break;
    }
  }
  Firestore.instance
      .collection('classes')
      .document('$code/updates/announcements')
      .updateData({'announcements': announcements});
  final snackBar =
      SnackBar(content: Text('You have responded $text successfully'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<String> getPollResponse(String key) async {
  String response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  response = prefs.getString(key) ?? '';
  return response;
}

void storeFCMToken(String code) {
  print('store FCM token started!!!');
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  _firebaseMessaging.getToken().then((deviceToken) {
//    print('Device Token : $deviceToken');
//    Firestore.instance
//        .collection('classes/$code/fcmTokens')
//        .document('fcmTokens')
//        .setData({
//      'fcmTokens': FieldValue.arrayUnion([deviceToken])
//    }, merge: true);
//  });
}

void deleteFCMToken(String code) {
  print('delete FCM token started!!!');
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  _firebaseMessaging.getToken().then((deviceToken) async {
//    print('Device Token : $deviceToken');
//    var data = await Firestore.instance
//        .collection('classes/$code/fcmTokens')
//        .document('fcmTokens')
//        .get();
//    List<dynamic> newTokens = [], fcmTokens = data['fcmTokens'];
//    for (int i = 0; i < fcmTokens.length; i++) {
//      if (fcmTokens[i] != deviceToken) newTokens.add(fcmTokens[i]);
//    }
//    Firestore.instance
//        .collection('classes/$code/fcmTokens')
//        .document('fcmTokens')
//        .updateData({'fcmTokens': newTokens});
//  });
}

String loginErrorCodes(dynamic e) {
  String _errorMessage = '';
  switch (e.code) {
    case "ERROR_INVALID_EMAIL":
      _errorMessage = "Please enter a valid email address.";
      break;
    case "ERROR_WRONG_PASSWORD":
      _errorMessage = "Incorrect password entered.";
      break;
    case "ERROR_USER_NOT_FOUND":
      _errorMessage = "User with this email doesn't exist.";
      break;
    case "ERROR_USER_DISABLED":
      _errorMessage = "User with this email has been disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
      _errorMessage = "Too many requests. Please try again later.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      _errorMessage = "Signing in with Email and Password is not enabled.";
      break;
    case "ERROR_WEAK_PASSWORD":
      _errorMessage = "Your password is too weak";
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
      _errorMessage = "Email is already in use on different account";
      break;
    case "ERROR_INVALID_CREDENTIAL":
      _errorMessage = "Your email is invalid";
      break;
    default:
      _errorMessage = "An undefined Error happened.";
  }
  return _errorMessage;
}
