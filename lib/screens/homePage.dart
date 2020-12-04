import 'package:flutter/material.dart';
import 'package:timetable/screens/teacherPage.dart';
import 'package:timetable/services/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key key,
      this.email,
      this.auth,
      this.userId,
      this.logoutCallback,});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId, email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: 
         Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(          
          children: <Widget>[
            Container(
              height: 160,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        'https://usersthink.com/img/99-free-images-small/02-usersthink-stock-image-small.jpg',
                        fit: BoxFit.fitWidth),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: (MediaQuery.of(context).size.width - 100) / 10,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Image.network('https://laayak2.web.app/logo.png'),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: (MediaQuery.of(context).size.width - 170),
                    child: headingText('LaayaK'),
                  ),
                ],
              ),
            ),        
            headingText3('Welcome'),
            headingText3(
                'You haven\'t been added to any class yet. \n\n We\'ll update you soon when your are'),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Go to Home Page',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.pinkAccent),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ), 
          Column(
            children: [
              Text('TEACHER PAGE!!! Find classes!'),
              FlatButton(child: Text('Go to Home Page'),
                  onPressed: () {

                // this is the class-> find code and send data and code accordingly

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> TeacherPage(
                          userId: widget.userId,
                          auth: widget.auth,
                          logoutCallback: widget.logoutCallback,
                          email: widget.email,
                      )
                    ));
                  }
              ),
              FlatButton(
                child: Text('Logout'),
                onPressed: (){
                  widget.auth.signOut();
                  widget.logoutCallback();
                }
              )
            ],
          ),
        )
    );
  }
}
