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
    return Container();
  }
}
