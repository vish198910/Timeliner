/* import 'package:flutter/material.dart';
import 'timeline.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimeLiner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimelinePage(title: 'TimeLiner'),
    );
  }
}
 */
/* 
import 'package:Timeliner/screens/use_case.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vishnu Sharma',
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            body: new Container(
          child: new TrackIt(),
        )));
  }
}
 */

import 'package:Timeliner/screens/use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:TrackIt()
  ));
}
