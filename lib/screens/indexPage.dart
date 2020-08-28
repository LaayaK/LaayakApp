import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text('LINK AAYA KYA?'),
            TextFormField(
              decoration: InputDecoration(
                suffix: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: null,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Text('If you are a CR'),
                RaisedButton(
                  child: Text('Login Here'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
