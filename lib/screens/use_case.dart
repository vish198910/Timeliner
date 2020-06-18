import 'package:Timeliner/place_tracker/place_tracker_app.dart';
import 'package:Timeliner/timeline.dart';
import 'package:Timeliner/utils/beautify.dart';
import 'package:provider/provider.dart';
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
        elevation: 50,
        centerTitle: true,
        backgroundColor: firstColor,
        title: Text("YOUR TRACKS"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
            child: SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return TimelinePage(title: "JOURNAL",);
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: firstColor,
                  child: Text("JOURNAL",style: TextStyle(fontSize:30,color: Colors.white),)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainPage();
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: firstColor,
                  child:Text("RESUME",style: TextStyle(fontSize:30,color: Colors.white),)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangeNotifierProvider(
                      create: (context) => AppState(),
                      child: PlaceTrackerApp(),
                    );
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: firstColor,
                  child:Text("LOCATION",style: TextStyle(fontSize:30,color: Colors.white),)),
              ),
            ),
          ),
        ]),
      ),
      
    );
  }
}
