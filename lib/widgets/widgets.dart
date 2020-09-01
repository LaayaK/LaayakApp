import 'package:flutter/material.dart';
import 'package:timetable/widgets/functions.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:ui';
import 'package:timetable/services/notification.dart';

class AddLecture extends StatefulWidget {
  AddLecture({this.code, this.subjectCode, this.teacher, this.subject});

  final String code, subjectCode, subject, teacher;

  @override
  State<StatefulWidget> createState() => AddLectureState();
}

class AddLectureState extends State<AddLecture>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  String link, desc;
  static DateTime initDate = DateTime.now();
  DateTime startTime = initDate, endTime = initDate;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      if (startTime == initDate || endTime == initDate) return false;
      form.save();
      print('Form Validated');
      return true;
    } else
      print('Form Not Validated');
    return false;
  }

  // Send data
  void validateAndSubmit() {
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

        addLectureLinkFirestore(widget.code, lecture);
        Navigator.pop(context);

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
                height: 500.0,
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
                        Text('Add Lecture',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18,
                            )),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Meeting Link'),
                            validator: (value) =>
                                (value.isEmpty || !Uri.parse(value).isAbsolute)
                                    ? 'Enter Valid Link'
                                    : null,
                            onSaved: (value) => link = value.trim(),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(children: <Widget>[
                          Text('Start Time',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          Spacer(),
                          Text(getTime(startTime),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          SizedBox(
                            width: 50,
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      showSecondsColumn: false,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    setState(() {
                                      if (date.hour >= DateTime.now().hour)
                                        startTime = date;
                                      else
                                        startTime = DateTime.now();
                                    });
                                  }, currentTime: DateTime.now());
                                },
                                child: Icon(Icons.timer, color: Colors.blue)),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Text('End Time',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          Spacer(),
                          Text(getTime(endTime),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          SizedBox(
                            width: 50,
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      showSecondsColumn: false,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    setState(() {
                                      if (date.hour >= DateTime.now().hour ||
                                          date.hour > startTime.hour) if (date
                                                  .hour ==
                                              startTime.hour &&
                                          date.minute > startTime.minute)
                                        endTime = date;
                                      else
                                        endTime = initDate;
                                      else
                                        endTime = initDate;
                                    });
                                  }, currentTime: DateTime.now());
                                },
                                child: Icon(Icons.timer, color: Colors.blue)),
                          ),
                        ]),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            maxLines: 5,
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
                            label: Text('Add Lecture'),
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

class AddAnnoun extends StatefulWidget {
  AddAnnoun({this.code});

  final String code;

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

  String text;

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

        Map<String, dynamic> announcement = {
          'text': text,
          'dateAndTime': DateTime.now(),
        };

        addAnnouncementFirestore(widget.code, announcement);
        Navigator.pop(context);

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
              height: 400,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    width: 5,
                    color: Colors.grey.shade400,
                  ),
                ),

                // dashed Border
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Add Announcement',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      //                         margin: EdgeInsets.only(right: 10),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter text'),
                        validator: (value) => (value.isEmpty)
                            ? 'Pleas Enter the announcement'
                            : null,
                        onSaved: (value) => text = value.trim(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget subjectCR(BuildContext context, dynamic data, String code) {
  return Container(
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
          builder: (_) => AddLecture(
              code: code,
              subjectCode: data['subjectCode'],
              subject: data['subject'],
              teacher: data['teacher']),
        );
      },
      child: Column(children: <Widget>[
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
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
            margin: EdgeInsets.only(right: 10),
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(data['subject'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                SizedBox(height: 2),
                Text('by ${data['teacher']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    )),
              ])),
        ]),
      ]),
    ),
  );
}

Widget buildWaitingScreen() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      alignment: Alignment.center,
      child: Text('LINK AAYA KYA???'),
    ),
  );
}

Widget lectureCard(BuildContext context, dynamic data) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//    height: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0.0, 0.4),
          blurRadius: 3,
          color: Colors.grey.shade300,
        )
      ],
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(children: <Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          height: 80,
          width: 60,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(getTime(data['startTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
                Text('|',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
                Text(getTime(data['endTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
              ]),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
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
              Text(data['subject'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              SizedBox(height: 2),
              Text('by ${data['teacher']}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
              SizedBox(height: 7),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 170) / 3,
                      height: 30,
                      decoration: BoxDecoration(),
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => details(context, data),
//                              {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (BuildContext context) =>
//                                        SetAlarm(context:context, data:data)));
//                          },
                          child: Text('DETAILS',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: 15,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 190) / 3,
                      height: 30,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            launchUrl(data['link']);
                          },
                          child: Text('JOIN',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: 15,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: (MediaQuery.of(context).size.width - 190) / 3,
                      height: 30,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            copyText(context, data['link']);
                          },
                          child: Text('COPY',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ))),
                    ),
                  ]),
            ])),
      ]),
    ]),
  );
}

Widget lectureDetails(BuildContext context, dynamic data) {
  return new Container(
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15), topLeft: Radius.circular(15)),
    ),
    height: 300,
    child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 40,
        color: Colors.grey.shade300,
        child: Center(
          child: Text('Lecture details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: 1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(data['subject'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Text('by ${data['teacher']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 35,
                        width: 120,
                        child: SetAlarm(),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Additional Information',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(data['desc'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )))
                    ],
                  ),
                ),
              );
            }),
      )
    ]),
  );
}

Widget announcementCard(BuildContext context, dynamic data) {
  double widthC = MediaQuery.of(context).size.width - 80;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade200)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: 35,
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
          height: 55,
          width: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.green,
          ),
        ),
        Container(
          width: widthC,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    getTime(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    getDate(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                data['text'],
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
  );
}

Widget headingText(String text) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
    ),
  );
}

class AddLink extends StatefulWidget {
  AddLink({this.code});

  final String code;

  @override
  State<StatefulWidget> createState() => AddLinkState();
}

class AddLinkState extends State<AddLink> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  String link, desc;

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

        Map<String, dynamic> linkData = {
          'link': link,
          'dateAndtime': DateTime.now(),
          'desc': desc,
        };

        addLinkFirestore(widget.code, linkData);
        Navigator.pop(context);

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
        CurvedAnimation(parent: controller, curve: Curves.decelerate);

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
              height: 400,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    width: 5,
                    color: Colors.grey.shade400,
                  ),
                ),

                // dashed Border
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Send Link',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      //                         margin: EdgeInsets.only(right: 10),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.url,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter Link'),
                        validator: (value) =>
                            (value.isEmpty || !Uri.parse(value).isAbsolute)
                                ? 'Enter Link'
                                : null,
                        onSaved: (value) => link = value.trim(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add description'),
                        validator: (value) =>
                            (value.isEmpty) ? 'Enter Description' : null,
                        onSaved: (value) => desc = value.trim(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddPoll extends StatefulWidget {
  AddPoll({this.code});

  final String code;

  @override
  State<StatefulWidget> createState() => AddPollState();
}

class AddPollState extends State<AddPoll> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  String option1, option2, desc;

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

        Map<String, dynamic> poll = {
          option1: 0,
          option2: 0,
          'desc': desc,
          'dateAndTime': DateTime.now()
        };

        addPollFirestore(widget.code, poll);
        Navigator.pop(context);

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
        CurvedAnimation(parent: controller, curve: Curves.decelerate);

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
              height: 400,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    width: 5,
                    color: Colors.grey.shade400,
                  ),
                ),

                // dashed Border
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Generate Poll ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      //                         margin: EdgeInsets.only(right: 10),
                      height: 2,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add description'),
                        validator: (value) =>
                            (value.isEmpty) ? 'Enter Description' : null,
                        onSaved: (value) => desc = value.trim(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      Container(
                        //                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: (MediaQuery.of(context).size.width - 90) * 0.5,
                        height: 40,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Option 1',
                              ),
                              validator: (value) =>
                                  (value.isEmpty) ? 'Enter Option 1' : null,
                              onSaved: (value) => option1 = value.trim()),
                        ),
                      ),
                      Container(
                        //                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: (MediaQuery.of(context).size.width - 90) * 0.5,
                        height: 40,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Option 2'),
                              validator: (value) =>
                                  (value.isEmpty) ? 'Enter Option 2' : null,
                              onSaved: (value) => option2 = value.trim()),
                        ),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaddedRaisedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PaddedRaisedButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
    );
  }
}

Widget pollCard(BuildContext context, dynamic data) {
  double widthC = MediaQuery.of(context).size.width - 80;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
     decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                  offset: Offset(0,1),
                  blurRadius: 7,
                  color: Colors.grey.shade500,                    
                  ),
                ],
              ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
//                     margin: EdgeInsets.symmetric(horizontal: 2),
                    height: 35,
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    height: 55,
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 35,
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.pinkAccent,
                    ),
                  ),
        Container(
          width: widthC,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    getTime(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    getDate(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                data['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                               margin: EdgeInsets.symmetric(horizontal: 5),
                                   width:
                                    (MediaQuery.of(context).size.width - 100) *
                                        0.5,
                                  child:RaisedButton(                                 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.green,
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                            data['yesOption'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {},
                                ),),
//                               ),
                             Container(
                               margin: EdgeInsets.symmetric(horizontal: 5),
                                   width:
                                    (MediaQuery.of(context).size.width - 100) *
                                        0.5,
                                  child:RaisedButton(                                 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                            data['noOption'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {},
                                ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget pollCardCR(BuildContext context, dynamic data) {
  double widthC = MediaQuery.of(context).size.width - 80;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 1, color: Colors.grey.shade200),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: 35,
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
          height: 55,
          width: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.green,
          ),
        ),
        Container(
          width: widthC,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    getTime(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    getDate(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                data['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '${data['yesOption']} : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      TextSpan(
                          text: data['yesCount'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green)),
                    ])),
                    Spacer(),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '${data['noOption']} : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      TextSpan(
                          text: data['noCount'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.red)),
                    ])),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget linkCard(BuildContext context, dynamic data) {
  double widthC = MediaQuery.of(context).size.width - 80;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 1, color: Colors.grey.shade200),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: 35,
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
          height: 55,
          width: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.green,
          ),
        ),
        Container(
          width: widthC,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    getTime(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    getDate(data['dateAndTime'].toDate()),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                data['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      data['link'],
                      style: TextStyle(color: Colors.blue),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width:
                                (MediaQuery.of(context).size.width - 100) * 0.5,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.green),
                            child: FlatButton(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  'Copy Link',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                copyText(context, data['link']);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width:
                                (MediaQuery.of(context).size.width - 100) * 0.5,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.blue),
                            child: FlatButton(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  'Visit Link',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                launchUrl(data['link']);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
