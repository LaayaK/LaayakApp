import 'package:flutter/material.dart';

class CreateStudent extends StatefulWidget {
  @override
  _CreateStudentState createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {

  String _name, _email, _password, _rollNo, _classCode;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _rollNoController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _classCodeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              headingText('Student'),
              showInput('Class Code'), 
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

 Widget showInput(String hint) {
    return Container(
      margin: EdgeInsets.all(10),
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
Widget showPasswordInput() {
  return Container(
    margin: EdgeInsets.all(10),
    child: new TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      onChanged: (value) {
//           setState(() {
//             _isButtonDisabled = false;
//             print('password tapped');
//           });
      },
      decoration: new InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintText: 'Enter Password',
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
      ),
//         validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
//         onSaved: (value) => _password = value.trim(),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color(0xFFE5E5E5),
    ),
  );
}
// }
