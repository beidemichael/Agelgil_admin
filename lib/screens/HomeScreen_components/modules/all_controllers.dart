import 'dart:math';

import 'package:agelgil_admin_end/screens/lounge_modules.dart/widgets/toggle_button.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';

import 'package:agelgil_admin_end/model/Models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AllController extends StatefulWidget {
  @override
  _AllControllerState createState() => _AllControllerState();
}

class _AllControllerState extends State<AllController> {
  double deliveryFee;
  double sFStartsAt;
  double serviceCharge;
  bool referralCodeOrder;
  bool referralCodeLogin;
  String documentId;
  bool gotData = false;
  getDate(List<Controller> allController) {
    deliveryFee = allController[0].deliveryFee;
    sFStartsAt = allController[0].sFStartsAt;
    serviceCharge = allController[0].serviceCharge;
    referralCodeOrder = allController[0].referralCodeOrder;
    referralCodeLogin = allController[0].referralCodeLogin;
    documentId = allController[0].documentId;
  }

  @override
  Widget build(BuildContext context) {
    final allController = Provider.of<List<Controller>>(context) ?? [];
    if (allController != null) {
      if (allController.isNotEmpty) {
        if (gotData == false) {
          getDate(allController);
          if (allController.length > 0) {
            gotData = true;
          }
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          allController == null
              ? Center(
                  child: SpinKitCircle(
                  color: Colors.orange,
                  size: 50.0,
                ))
              : allController.length == 0
                  ? Center(
                      child: SpinKitCircle(
                      color: Colors.orange,
                      size: 50.0,
                    ))
                  : Container(
                      child: allController.isEmpty
                          ? Center(
                              child: Text('You don\'t have any controller',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w600)),
                            )
                          : Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10, bottom: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[600],
                                        blurRadius:
                                            1.0, //effect of softening the shadow
                                        spreadRadius:
                                            0.5, //effecet of extending the shadow
                                        offset: Offset(
                                            0.0, //horizontal
                                            1.0 //vertical
                                            ),
                                      ),
                                    ],
                                    color: Colors.orange[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(30.0)),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Service Charge',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  serviceCharge =
                                                      double.parse(val);
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 20),
                                                labelText:
                                                    serviceCharge.toString(),
                                                focusColor: Colors.orange[900],
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15.0,
                                                    color: Colors.grey[800]),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[400])),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .orange[200])),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Delivery Fee',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  deliveryFee =
                                                      double.parse(val);
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 20),
                                                labelText:
                                                    deliveryFee.toString(),
                                                focusColor: Colors.orange[900],
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15.0,
                                                    color: Colors.grey[800]),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[400])),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .orange[200])),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Service Charge starts at',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            TextFormField(
                                              onChanged: (val) {
                                                setState(() {
                                                  sFStartsAt =
                                                      double.parse(val);
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 20),
                                                labelText:
                                                    sFStartsAt.toString(),
                                                focusColor: Colors.orange[900],
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15.0,
                                                    color: Colors.grey[800]),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey[400])),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .orange[200])),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Refferal code when logging in',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Transform.rotate(
                                              angle: 180 * (pi / 180),
                                              child: InkWell(
                                                onTap: () {
                                                  if (referralCodeLogin ==
                                                      false) {
                                                    setState(() {
                                                      referralCodeLogin = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      referralCodeLogin = false;
                                                    });
                                                  }
                                                  // DatabaseService(
                                                  //         id: widget.documentId)
                                                  //     .updateLoungeEatThereAvailable(
                                                  //         eatThereAvailable);
                                                },
                                                child: ToggleButton(
                                                  isAvaliable:
                                                      referralCodeLogin,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 1),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Refferal code when ordering   ',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Transform.rotate(
                                              angle: 180 * (pi / 180),
                                              child: InkWell(
                                                onTap: () {
                                                  if (referralCodeOrder ==
                                                      false) {
                                                    setState(() {
                                                      referralCodeOrder = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      referralCodeOrder = false;
                                                    });
                                                  }
                                                  // DatabaseService(
                                                  //         id: widget.documentId)
                                                  //     .updateLoungeEatThereAvailable(
                                                  //         eatThereAvailable);
                                                },
                                                child: ToggleButton(
                                                  isAvaliable:
                                                      referralCodeOrder,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 1),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                      GestureDetector(
                                        onTap: () {
                                          DatabaseService(id: documentId)
                                              .updateController(
                                            deliveryFee,
                                            sFStartsAt,
                                            serviceCharge,
                                            referralCodeOrder,
                                            referralCodeLogin,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  50,
                                              height: 50,
                                              child: Center(
                                                child: Text('Update',
                                                    style: TextStyle(
                                                        fontSize: 21.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w100)),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35.0))),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
        ],
      ),
    );
  }
}
