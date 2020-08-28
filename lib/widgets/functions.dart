import 'package:flutter/material.dart';
import 'package:timetable/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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