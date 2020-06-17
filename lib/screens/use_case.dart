import 'package:Timeliner/ui/main_page.dart';
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
            height: 200,
            child: GestureDetector(
              child: Center(child: Text("Bio")),
            ),
          ),
          SizedBox(
            height: 200,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return MainPage();
                }));
              },
              child: Center(child: Text("Resume")),
            ),
          ),
          SizedBox(
            height: 200,
            child: GestureDetector(
              child: Container(child: Center(child: Text("Location"))),
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
