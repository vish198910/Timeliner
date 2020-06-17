import 'package:flutter/material.dart';

class TrackIt extends StatefulWidget {
  @override
  _TrackItState createState() => _TrackItState();
}

class _TrackItState extends State<TrackIt> {
  List<Widget> tracks = new List<Widget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost Track of Something"),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          SizedBox(
            height: 20,
            child: GestureDetector(
              child: Text("Bio"),
            ),
          ),
          SizedBox(
            height: 20,
            child: GestureDetector(
              child: Text("Resume"),
            ),
          ),
          SizedBox(
            height: 20,
            child: GestureDetector(
              child: Text("Location"),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        return AlertDialog();
      }),
    );
  }
}
