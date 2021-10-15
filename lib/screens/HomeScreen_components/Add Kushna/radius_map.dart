import 'package:agelgil_admin_end/screens/HomeScreen_components/Add Kushna/location_ask.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:agelgil_admin_end/shared/loading.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class RadiusMap extends StatefulWidget {
  String loungeUid = '';
  String loungePhone = '';
  RadiusMap({this.loungePhone, this.loungeUid});
  @override
  _RadiusMapState createState() => _RadiusMapState();
}

class _RadiusMapState extends State<RadiusMap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final geo = Geoflutterfire();
  GoogleMapController _controller;
  static LatLng _initialPosition;
  LatLng _lastMapPosition;
  Map<MarkerId, Circle> circleA = <MarkerId, Circle>{};
  double zoomLevel;
  double newRadius;
  List<String> category = ['others'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
    locationPermitionHandler();
  }

  locationPermitionHandler() async {
    bool locaionIsOn = await Permission.location.serviceStatus.isEnabled;
    if (locaionIsOn == true) {
      print('on');
    } else {
      print('not');
      AskLocationDialog alert =
          AskLocationDialog(turnOnLocation: openLocationSetting);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  void _getUserLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _initialPosition == null
              ? Loading()
              : GoogleMap(
                  mapType: MapType.hybrid,
                  onCameraMove: _onCameraMove,
                  tiltGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    tilt: 0,
                    bearing: 0,
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  circles: Set<Circle>.of(circleA.values),
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    setState(() {
                      circleA[MarkerId('a')] = Circle(
                          circleId: CircleId("A"),
                          center: LatLng(_initialPosition.latitude,
                              _initialPosition.longitude),
                          radius: 15,
                          fillColor: Colors.orange.withOpacity(0.5),
                          strokeColor: Colors.orange[200].withOpacity(0.5),
                          strokeWidth: 10);
                    });
                  },
                ),
          Center(
            child: _initialPosition == null
                ? Container()
                : Center(
                    child: Image(
                      color: Colors.orange[400],
                      image: AssetImage("images/position.png"),
                      height: 70,
                      width: 70,
                    ),
                  ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Text(
                  "Place your adress at the center",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.arrowLeft,
                      size: 25.0, color: Colors.grey[700]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: GestureDetector(
              onTap: () {
                GeoFirePoint myLocation = geo.point(
                    latitude: _lastMapPosition.latitude,
                    longitude: _lastMapPosition.longitude);
                DatabaseService().addNewLounge(
                    widget.loungeUid, widget.loungePhone, myLocation, category);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 120.0,
                height: 60.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 2.0, //effect of softening the shadow
                      spreadRadius: 0.5, //effecet of extending the shadow
                      offset: Offset(
                          0.0, //horizontal
                          0.0 //vertical
                          ),
                    ),
                  ],
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(60.0),
                ),
                child: Center(
                  child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
