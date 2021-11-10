import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:timetable/services/authentication.dart';
import 'package:timetable/services/rootPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaayaK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: 'Roboto-Regular',
      ),
      home: new RootPage(auth: new Auth()),
      routes: {
        '/main': (context) => RootPage(auth: new Auth()),
      },
    );
  }
}
