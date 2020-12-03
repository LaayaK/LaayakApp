import 'package:flutter/material.dart';

class createClass extends StatefulWidget {
  @override
  _createClassState createState() => _createClassState();
}

class _createClassState extends State<createClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(            
            children: <Widget>[
              SizedBox(height: 10),
              headingText('Welcome to Laayak'),
              headingText2('Create your class'),
              showInput('College'), 
              showInput('Branch'), 
              showInput('Course'),
              showInput('Semester'),                                          
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
                      'Create Class',
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
Widget headingText2(String text) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black54, fontSize: 30, fontFamily: 'Comfortaa'),
    ),
  );
}

  Widget showInput(String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal:30),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
//         validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//         onSaved: (value) => _email = value.trim(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFE5E5E5),
      ),
    );
  }
