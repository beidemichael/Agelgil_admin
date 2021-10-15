
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadiusMap extends StatefulWidget {
  String documentId;
  double radius;
  double latitude;
  double longitude;
  RadiusMap({this.radius, this.latitude, this.longitude, this.documentId});
  @override
  _RadiusMapState createState() => _RadiusMapState();
}

class _RadiusMapState extends State<RadiusMap> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GoogleMapController _controller;
  static LatLng _initialPosition;
  Map<MarkerId, Marker> loungeMarkers = <MarkerId, Marker>{};
  Map<MarkerId, Circle> circleA = <MarkerId, Circle>{};
  double zoomLevel;
  double newRadius;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialPosition = LatLng(widget.latitude, widget.longitude);
    newRadius = widget.radius;
  }

  getZoomLevel() {
    double zoomLevel = 11;

    double radius = newRadius + newRadius / 2;
    double scale = radius / 500;

    zoomLevel = (16 - log(scale) / log(2));

    return zoomLevel;
  }

  void updateZoom() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        bearing: 0,
        target: LatLng(widget.latitude, widget.longitude),
        tilt: 0,
        zoom: getZoomLevel())));

    circleA[MarkerId('a')] = Circle(
        circleId: CircleId("A"),
        center: LatLng(widget.latitude, widget.longitude),
        radius: newRadius,
        fillColor: Colors.orange.withOpacity(0.5),
        strokeColor: Colors.orange[200].withOpacity(0.5),
        strokeWidth: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,

            tiltGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              tilt: 0,
              bearing: 0,
              target: _initialPosition,
              zoom: getZoomLevel(),
            ),
            markers: Set<Marker>.of(loungeMarkers.values),
            circles: Set<Circle>.of(circleA.values),
            // _markers,
            compassEnabled: false,
            // onCameraMove: _onCameraMove,
            zoomControlsEnabled: false,

            // rotateGesturesEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;

              setState(() {
                loungeMarkers[MarkerId('me')] = Marker(
                  markerId: MarkerId('me'),
                  position: _initialPosition,
                );

                circleA[MarkerId('a')] = Circle(
                    circleId: CircleId("A"),
                    center: LatLng(widget.latitude, widget.longitude),
                    radius: newRadius,
                    fillColor: Colors.orange.withOpacity(0.5),
                    strokeColor: Colors.orange[200].withOpacity(0.5),
                    strokeWidth: 10);
              });
            },
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
            bottom: -40,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100].withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Radius can\'t be empty' : null,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            newRadius = double.parse(val);
                          },
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500
                              // decorationColor: Colors.white,
                              ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),

                            //Label Text/////////////////////////////////////////////////////////

                            focusColor: Colors.orange[900],
                            labelText: newRadius.toString() + 'm',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.grey[800]),
                            /* hintStyle: TextStyle(
                                              color: Colors.orange[900]
                                              ) */
                            ///////////////////////////////////////////////

                            //when it's not selected////////////////////////////
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey[400])),
                            ////////////////////////////////

                            ///when textfield is selected//////////////////////////
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide:
                                    BorderSide(color: Colors.orange[200])),
                            ////////////////////////////////////////
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            DatabaseService(id: widget.documentId)
                                .updateRadius(newRadius);

                            updateZoom();
                            setState(() {
                              newRadius = newRadius;
                            });
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: Center(
                              child: Text('Update',
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100)),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(35.0))),
                      ),
                    ],
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
