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
    .document(code)
    .setData({
      'lecturesToday': FieldValue.arrayUnion([lecture])
    }, merge: true);
}