import 'package:flutter/material.dart';
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
