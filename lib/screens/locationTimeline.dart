import 'package:Timeliner/experiences.dart';
//import 'package:Timeliner/place_tracker/place.dart';
import 'package:Timeliner/utils/beautify.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import "package:Timeliner/data.dart";

class LocationTimelinePage extends StatefulWidget {
  LocationTimelinePage(
      {Key key, this.title, this.list})
      : super(key: key);
  final String title;
  final List list;
  
  @override
  _LocationTimelinePageState createState() => _LocationTimelinePageState();
}

class _LocationTimelinePageState extends State<LocationTimelinePage> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIx,
            onTap: (i) => pageController.animateToPage(i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_left),
                title: Text("LEFT"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center),
                title: Text("CENTER"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_right),
                title: Text("RIGHT"),
              ),
            ]),
        appBar: AppBar(
          elevation: 50,
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: firstColor,
        ),
        body: PageView(
          onPageChanged: (i) => setState(() => pageIx = i),
          controller: pageController,
          children: pages,
        ));
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: widget.list.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = widget.list[i];
    return TimelineModel(
        Card(
          color: firstColor,
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(""),
                const SizedBox(
                  height: 8.0,
                ),
                Text("", style: TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "${doodle["latitude"]} ${doodle["longitude"]}",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: firstColor,
        icon: Icon(Icons.timelapse));
  }
}
