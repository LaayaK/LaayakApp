import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetable/screens/homePage.dart';

class AuthPath extends StatefulWidget {
  @override
  _AuthPathState createState() => _AuthPathState();
}

class _AuthPathState extends State<AuthPath> {
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  Future<void> checkBio() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;

      print(_hasBioSensor);

      if(_hasBioSensor!){
        _getAuth()
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAuth() async{
    bool isAuth = false;
    try{
      isAuth =await authentication.authenticate(
        localizedReason: 'Scan your Finger Print here'
            biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true
      );

      if(isAuth){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>HomePage());
      }

      print(isAuth);
    }on PlatformException catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkBio();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
