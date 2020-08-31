import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable/screens/addLecture.dart';
import 'package:timetable/widgets/widgets.dart';

class AddDataPage extends StatefulWidget {
  AddDataPage({this.code});

  final String code;

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          headingText('Add Notification'),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(0),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 0.4),
                  blurRadius: 3,
                  color: Colors.grey.shade300,
                )
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddLecturePage(code: widget.code)));
              },
              child: Column(children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.edit, color: Colors.green, size: 30),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 45,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Text('Lecture',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                          ])),
                    ]),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(0),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 0.4),
                  blurRadius: 3,
                  color: Colors.grey.shade300,
                )
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AddAnnoun(),
                );
              },
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.speaker_notes,
                            color: Colors.green, size: 30),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 45,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Announcement',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: EdgeInsets.all(0),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 0.4),
                  blurRadius: 3,
                  color: Colors.grey.shade300,
                )
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AddAnnoun(),
                );
              },
              child: Column(children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.link, color: Colors.green, size: 30),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 45,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 25,
                        width: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Text('Link',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                          ])),
                    ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class AddAnnoun extends StatefulWidget {
  AddAnnoun({this.announ, this.subjectCode, this.teacher, this.subject});

  final String announ, subjectCode, subject, teacher;

  @override
  State<StatefulWidget> createState() => AddAnnounState();
}

class AddAnnounState extends State<AddAnnoun>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  String link, startTime = '00:00', endTime = '00:00', desc;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form Validated');
      return true;
    } else
      print('Form Not Validated');
    return false;
  }

  // Send data
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (validateAndSave()) {
      _isLoading = true;
      try {
        //Add data to Database

        Map<String, dynamic> lecture = {
          'subject': widget.subject,
          'subjectCode': widget.subjectCode,
          'teacher': widget.teacher,
          'link': link,
          'startTime': startTime,
          'endTime': endTime,
          'desc': desc,
        };

        print(lecture);
        //         addLectureLinkFirestore(widget.code, lecture);

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Form(
        key: _formKey,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                height: 370.0,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(width: 5, color: Colors.grey)),

                    // dashed Border
                    child: Column(
                      children: <Widget>[
                        Text('Add Announcement',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18,
                            )),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            maxLines: 10,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Additional Information'),
                            onSaved: (value) => (value.isNotEmpty)
                                ? desc = value.trim()
                                : desc = 'No information',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              validateAndSubmit();
                            },
                            label: Text('Send'),
                            icon: Icon(Icons.check_circle_outline),
                            elevation: 1,
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
