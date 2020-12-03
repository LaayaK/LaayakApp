import 'package:flutter/material.dart';

class CreateCr extends StatefulWidget {
  @override
  _CreateCrState createState() => _CreateCrState();
}

class _CreateCrState extends State<CreateCr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(            
            children: <Widget>[
              SizedBox(height: 10),
              headingText('Class Representative'),
              showInput('Name'), 
              showInput('Roll No.'), 
              showInput('Email'),               
              showPasswordInput(),                            
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
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),             
            ],
          ),
      ),
    );
  }
}
Widget headingText(String text) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 40, fontFamily: 'Lobster'),
    ),
  );
}
