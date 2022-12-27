import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCupertinoSheetSample extends StatefulWidget {
  @override
  _MyCupertinoSheetSampleState createState() => _MyCupertinoSheetSampleState();
}

class _MyCupertinoSheetSampleState extends State<MyCupertinoSheetSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Cupertino Sheet Sample')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              primary: Colors.orangeAccent),
          onPressed: () {
           
          },
          child: Text('Open Bottom Sheet',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
