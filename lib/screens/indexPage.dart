import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/screens/studentPage.dart';

//Authentication
import 'package:timetable/services/authentication.dart';

import 'package:timetable/screens/loginPage.dart';
import 'package:timetable/widgets/widgets.dart';

enum CodeStatus{
  NOT_DEFINED,
  CODE_PRESENT,
  NO_CODE
}

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  CodeStatus codeStatus = CodeStatus.NOT_DEFINED;
  String code = '';
  bool wrongCode = false;
  TextEditingController codeController = new TextEditingController();

  void getCode() async {
    print('getting code from SP');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('code') ?? '');
      print('code got from SP : $code');
      if (code.isNotEmpty)
        codeStatus = CodeStatus.CODE_PRESENT;
      else
        codeStatus = CodeStatus.NO_CODE;
    });
  }

  void verifyCode(String codeGot) async {
    print(codeGot);
    await Firestore.instance.collection('classes').document(codeGot).get().then((doc){
      setState(() {
        if (doc.exists) {
          code = codeGot;
          codeStatus = CodeStatus.CODE_PRESENT;
        }
      });
    }).catchError((error) {
      print('Error in getting document');
      print('error : $error');
    });
    if(codeStatus == CodeStatus.CODE_PRESENT)
    {
      print('code matched document ID');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('code', codeController.value.text);
    } else {
      print('code did not match any document ID');
      setState(() {
        codeStatus = CodeStatus.NO_CODE;
        wrongCode = true;
        codeController.clear();
      });
    }
  }

  @override
  initState(){
    super.initState();
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (codeStatus == CodeStatus.NOT_DEFINED)
        ? buildWaitingScreen()
        : (codeStatus == CodeStatus.NO_CODE)
          ? Container (
              child: Column(
                children: <Widget>[
                  Text('LINK AAYA KYA?'),
                  TextField(
                    controller: codeController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          wrongCode = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            codeStatus = CodeStatus.NOT_DEFINED;
                          });
                          verifyCode(codeController.value.text);
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: wrongCode,
                    child: Text('Wrong Code Entered')
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Text('If you are a CR'),
                      RaisedButton(
                        child: Text('Login Here'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  LoginSignUpPage(auth:widget.auth, loginCallback: widget.loginCallback,)
                              )
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : StudentPage(code: code)
    );
  }
}

// class IndexPage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//    return Scaffold(
//      backgroundColor: Colors.white,
//    body: Container(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//      children:<Widget>[
//        Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               padding: EdgeInsets.all(0),
//                 color: Colors.transparent,
//                 child: Column(children: <Widget>[
//                   Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 2),
//                           height: 45,
//                           width: 4,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                             color: Colors.blue,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 10),
//                           height: 85,
//                           width: 4,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                             color: Colors.green,
//                           ),
//                         ),
//                         Container(                         
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                               Text('LINK AAYA',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold
//                                   )),
//                                   Text('KYA?',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold
//                                   )),                                                            
//                             ])),
//                       ]),
//                   SizedBox(height:240,
//                           child: Image.network('https://github.com/HimeshNayak/TimeTable/blob/master/assets/index.jpg')),
//               Container(
// //                  margin: EdgeInsets.only(10),
//                  width: 200,
//                  height:50,                
//                decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(10)),
//                  color: Colors.transparent,                 
//               ),
//                 child: TextField(
//                  decoration: InputDecoration(
//                  hintText: 'Enter Class Code',
//                  ),),
//               ),
//                            SizedBox(height: 50),
//                            Align(
//                              alignment: Alignment.bottomCenter,
//                              child: FlatButton(
//                              onPressed:(){},
//                            child: Text('Login as Class Representative', style: TextStyle(color: Colors.blue),),),)
//                 ]),
//               ), 
//      ]),
//    ),
//    ); 
//   }  
// }

