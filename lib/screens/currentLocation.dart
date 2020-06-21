import 'dart:async';
import 'dart:typed_data';

import 'package:Timeliner/database/database_helper.dart';
import 'package:Timeliner/model/location.dart';
import 'package:Timeliner/screens/locationTimeline.dart';
import 'package:Timeliner/utils/beautify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      home: MyHomePage(title: "What's my Location"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  List<Map<String, dynamic>> locationList = [];
  int locations = 0;

  final dbHelper = DatabaseHelper.instance;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/visited.png");
    return byteData.buffer.asUint8List();
  }

  void _insert(double latitude, double longitude) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnLatitude: latitude,
      DatabaseHelper.columnLongitude: longitude
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future<List<MyLocation>> _query() async {
    final List<Map<String,dynamic>> allRows = await dbHelper.queryAllRows();
    locations = allRows.length;
    locationList = allRows;
      return List.generate(allRows.length, (index) {
      return MyLocation(
        id: allRows[index]["id"],
        latitude: allRows[index]["latitude"],
        longitude: allRows[index]["longitude"]
      );
    });
  
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
        Map<String, dynamic> location = {
          "latitude": double.parse((newLocalData.latitude).toStringAsFixed(2)),
          "longitude": double.parse((newLocalData.longitude).toStringAsFixed(2))
        };
        _query();
        if (locations == 0) {
          _insert(double.parse((newLocalData.latitude).toStringAsFixed(2)),
            double.parse((newLocalData.longitude).toStringAsFixed(2)));
        } else {
          for (int i = 0; i < locations; i++) {
            if (locationList[i]["latitude"] == location["latitude"] &&
                locationList[i]["longitude"] == location["longitude"]) {
            } else {
              _insert(double.parse((newLocalData.latitude).toStringAsFixed(2)),
            double.parse((newLocalData.longitude).toStringAsFixed(2)));
            }
          }
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }
void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: firstColor,
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.list),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationTimelinePage(
                  title: "Timeline",
                  list: locationList,
                );
              }));
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: firstColor,
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
