import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:agelgil_admin_end/screens/lounge_modules.dart/1mainscreen/Lounge_home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:agelgil_admin_end/model/Models.dart';

import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:agelgil_admin_end/shared/loading.dart';
import 'package:android_intent/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'Add Kushna/location_ask.dart';

class Maps extends StatefulWidget {
  String userUid;

  String userName;
  String userPhone;
  String userPic;
  LatLng position;
  Function location;
  Function orderConfirmed;
  Maps(
      {this.userUid,
      this.userName,
      this.userPhone,
      this.userPic,
      this.position,
      this.location,
      this.orderConfirmed});
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with TickerProviderStateMixin {
  bool cartVisibiliy = false;
  int categoryList = 0;
  List categoryItems = [];
  double distance = 0;
  double deliveryDistance = 0;
  String loungeId = '';
  String loungeName = '';
  String loungePic = '';

  static LatLng _initialPosition;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor eateriesIcon;
  BitmapDescriptor supermarketIcon;
  GoogleMapController _controller;
  LatLng _lastMapPosition;
  double _zoom;
  double _bearing = 0;
  double markerPointerData;
  AnimationController animationController;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Map<MarkerId, Marker> loungeMarkers = <MarkerId, Marker>{};
  Map<MarkerId, Circle> circleA = <MarkerId, Circle>{};
  bool positionLoading = false;
  bool gotData = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();

    // animationController = new AnimationController(
    //   vsync: this,
    //   duration: new Duration(milliseconds: 360),
    // );
    // animationController.forward();
    // animationController.addListener(() {
    //   setState(() {
    //     if (animationController.status == AnimationStatus.completed) {
    //       animationController.repeat();
    //     }
    //   });
    // });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 0.5),
            'images/others/person.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 0.5), 'images/others/food.png')
        .then((onValue) {
      eateriesIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 0.5),
            'images/others/supermarket.png')
        .then((onValue) {
      supermarketIcon = onValue;
    });
  }

  ////////////////method for generating the over head text marker.
  Future<BitmapDescriptor> getMarkerName(
      final Color collor, String name, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = collor.withOpacity(0.5);
    final double tagWidth = 40.0;

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width, tagWidth + 20),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr, textAlign: TextAlign.left);
    textPainter.text = TextSpan(
      text: name,
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w800, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(40, 10));

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  getFromDatabase(List<Lounges> lounges) async {
    setState(() {
      loungeMarkers[MarkerId('me')] = Marker(
          markerId: MarkerId('me'),
          position: _initialPosition,
          icon: pinLocationIcon);
    });

    //for marker symbol
    for (int i = 0; i < lounges.length; i++) {
      deliveryDistance = calculateDistance(
          lounges[i].latitude,
          lounges[i].longitude,
          _initialPosition.latitude,
          _initialPosition.longitude);
      // print(deliveryDistance);

      int markerNumber = 0;
      var markerIdVal = lounges[i].documentId;
      String markerIdVal2 = lounges[i].documentId + markerNumber.toString();
      String markerIdVal3 = lounges[i].documentId +
          markerNumber.toString() +
          markerNumber.toString();
      String markerIdVal4 = lounges[i].documentId +
          markerNumber.toString() +
          markerNumber.toString() +
          markerNumber.toString();

      final MarkerId markerId = MarkerId(markerIdVal);

      // creating a new MARKER
      final Circle circle = Circle(
          circleId: CircleId(markerIdVal3),
          center: LatLng(lounges[i].latitude ?? 0, lounges[i].longitude ?? 0),
          radius: lounges[i].deliveryRadius ?? 0,
          fillColor: Colors.orange.withOpacity(0.3),
          strokeColor: Colors.red[500].withOpacity(0.5),
          strokeWidth: 2);
      //////////////////////////Over head text(name of eatery)//////////////////////

      final Marker markerName = Marker(
          onTap: () {
            if (lounges[i].name != null) {
              setState(() {
                categoryItems = lounges[i].category;
                categoryList = lounges[i].category.length;
                loungeName = lounges[i].name;
                loungeId = lounges[i].id;
                loungePic = lounges[i].images;
                distance = calculateDistance(
                    lounges[i].latitude,
                    lounges[i].longitude,
                    _initialPosition.latitude,
                    _initialPosition.longitude);
              });
            }
            lounges[i].category == null
                ? loading()
                : loungeDetailActivator(context);
          },
          markerId: markerId,
          anchor: Offset(0.5, 1.1),
          position: LatLng(lounges[i].latitude ?? 0, lounges[i].longitude ?? 0),
          icon: await getMarkerName(
              lounges[i].lounge == 'eatery' ? Colors.red : Colors.cyan,
              lounges[i].name,
              Size(lounges[i].name.length.toDouble() * 17 + 70, 150.0)));
      //////////////////////////Over head text(name of eatery)//////////////////////
      ///
      ///
      /////////////////////////////eatery symbol//////////////////////

      final Marker marker = Marker(
          markerId: MarkerId(markerIdVal2.toString()),
          position: LatLng(lounges[i].latitude ?? 0, lounges[i].longitude ?? 0),
          icon: lounges[i].lounge == 'eatery' ? eateriesIcon : supermarketIcon,
          // anchor: Offset(0.5, 1.5),
          onTap: () {
            if (lounges[i].name != null) {
              setState(() {
                categoryItems = lounges[i].category;
                categoryList = lounges[i].category.length;
                loungeName = lounges[i].name;
                loungeId = lounges[i].id;
                loungePic = lounges[i].images;
                distance = calculateDistance(
                    lounges[i].latitude,
                    lounges[i].longitude,
                    _initialPosition.latitude,
                    _initialPosition.longitude);
              });
            }
            lounges[i].category == null
                ? loading()
                : loungeDetailActivator(context);
          });

      /////////////////////////////eatery symbol//////////////////////
      ///
      ////////////////////////////////eatery open//////////////////////
      final Marker markerOpen = Marker(
          onTap: () {
            if (lounges[i].name != null) {
              setState(() {
                categoryItems = lounges[i].category;
                categoryList = lounges[i].category.length;
                loungeName = lounges[i].name;
                loungeId = lounges[i].id;
                loungePic = lounges[i].images;
                distance = calculateDistance(
                    lounges[i].latitude,
                    lounges[i].longitude,
                    _initialPosition.latitude,
                    _initialPosition.longitude);
              });
            }
            lounges[i].category == null
                ? loading()
                : loungeDetailActivator(context);
          },
          markerId: MarkerId(markerIdVal4.toString()),
          anchor: Offset(0.5, 2.3),
          position: LatLng(lounges[i].latitude ?? 0, lounges[i].longitude ?? 0),
          icon: await getMarkerName(
              lounges[i].weAreOpen == true ? Colors.orange[900] : Colors.grey[200],
              lounges[i].weAreOpen == true ? 'O' : 'X',
              Size(100, 100.0)));

      /////////////////////////////eatery open//////////////////////

      setState(() {
        // adding a new marker to map
        circleA[MarkerId(markerIdVal3.toString())] = circle;

        loungeMarkers[markerId] = markerName;
        loungeMarkers[MarkerId(markerIdVal2.toString())] = marker;
        loungeMarkers[MarkerId(markerIdVal4.toString())] = markerOpen;

      });

      // if (lounges[i].deliveryRadius < deliveryDistance) {
      //   loungeMarkers.remove(markerId);
      //   loungeMarkers.remove(MarkerId(markerIdVal2.toString()));
      // }
      markerNumber++;
    }
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    _zoom = position.zoom;
    _bearing = position.bearing;
  }

  // void setCompass() {
  //   _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //       bearing: 0,
  //       target: LatLng(_lastMapPosition.latitude, _lastMapPosition.longitude),
  //       tilt: 0,
  //       zoom: _zoom)));
  // }

  void _getUserLocation() async {
    setState(() {
      positionLoading = true;
    });
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      positionLoading = false;
      print(_initialPosition);
    });
    if (_controller != null) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: _bearing,
              target:
                  LatLng(widget.position.latitude, widget.position.longitude),
              tilt: 0,
              zoom: 17.00)));
    }
  }

  loungeDetailActivator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => LoungeHomeScreen(
                userUid: loungeId,
              )),
    );

    // LoungeDetailBlurryDialog alert = LoungeDetailBlurryDialog(
    //     widget.userName,
    //     widget.userPic,
    //     widget.userUid,
    //     widget.userPhone,
    //     categoryList,
    //     categoryItems,
    //     distance,
    //     loungeId,
    //     loungeName,
    //     loungePic,
    //     widget.orderConfirmed);

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }

  loading() {}

  @override
  Widget build(BuildContext context) {
    final lounges = Provider.of<List<Lounges>>(context) ?? [];
    if (lounges != null && _initialPosition != null) {
      if (gotData == false) {
        getFromDatabase(lounges);
        if (lounges.length > 0) {
          gotData = true;
        }
      }
    }

    return Scaffold(
      body: _initialPosition == null
          ? Loading()
          : lounges == null
              ? Loading()
              : Stack(
                  children: <Widget>[
                    Positioned(
                      child: Center(
                        child: GoogleMap(
                          mapType: MapType.satellite,

                          tiltGesturesEnabled: false,
                          initialCameraPosition: CameraPosition(
                            tilt: 0,
                            bearing: 0,
                            target: _initialPosition,
                            zoom: 17.00,
                          ),
                          markers: Set<Marker>.of(loungeMarkers.values),
                          circles: Set<Circle>.of(circleA.values),
                          // _markers,
                          compassEnabled: false,
                          onCameraMove: _onCameraMove,
                          zoomControlsEnabled: false,
                          // rotateGesturesEnabled: false,
                          mapToolbarEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            _controller = controller;

                            setState(() {
                              loungeMarkers[MarkerId('me')] = Marker(
                                  markerId: MarkerId('me'),
                                  position: _initialPosition,
                                  icon: pinLocationIcon);
                            });
                          },
                        ),
                      ),
                    ),
                    // Positioned(
                    //     bottom: 30.0,
                    //     right: 0.0,
                    //     child: LocationAndCompassBackground()),
                    Positioned(child: LocationButton()),
                    // Positioned(child: CompassButton()),
                  ],
                ),
    );
  }

  // LocationAndCompassBackground() {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 20.0),
  //     child: Container(
  //       // height: 22.0,
  //       width: 60.0,
  //       child: Image(
  //           image: AssetImage("images/others/opacitybehind.png"),
  //           fit: BoxFit.fill,
  //           color: Colors.white),
  //     ),
  //   );
  // }

  LocationButton() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 30.0,
          right: 0.0,
          // left: 0.0,
          // top: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  _getUserLocation();

                  // openLocationSetting();
                },
                child: Container(
                  width: 60.0,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Center(
                    child: positionLoading
                        ? Center(
                            child: SpinKitCircle(
                            color: Colors.orange,
                            size: 20.0,
                          ))
                        : Container(
                            height: 22.0,
                            width: 22.0,
                            child: Image(
                              image: AssetImage("images/others/position.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // CompassButton() {
  //   return Stack(
  //     children: <Widget>[
  //       Positioned(
  //         bottom: 125.0,
  //         right: 0.0,
  //         // left: 0.0,
  //         // top: 0.0,
  //         child: Padding(
  //           padding: const EdgeInsets.only(right: 20.0),
  //           child: Center(
  //             child: InkWell(
  //               onTap: () {
  //                 setCompass();
  //               },
  //               child: Container(
  //                 width: 60.0,
  //                 height: 60.0,
  //                 decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey[600],
  //                       blurRadius: 2.0, //effect of softening the shadow
  //                       spreadRadius: 0.5, //effecet of extending the shadow
  //                       offset: Offset(
  //                           0.0, //horizontal
  //                           0.0 //vertical
  //                           ),
  //                     ),
  //                   ],
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(60.0),
  //                 ),
  //                 child: Center(
  //                   child: AnimatedBuilder(
  //                     animation: animationController,
  //                     child: Container(
  //                       // color: Colors.red,
  //                       height: 25.0,
  //                       child: Image(
  //                         image: AssetImage("images/others/north.png"),
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     builder: (BuildContext context, Widget _widget) {
  //                       return new Transform.rotate(
  //                         angle: -_bearing * (pi / 180),
  //                         child: _widget,
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
