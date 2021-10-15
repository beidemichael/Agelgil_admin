import 'dart:ui';

import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/shared/concave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:marquee_widget/marquee_widget.dart';

import 'add_carrier_popup.dart';
import 'are_you_sure_you_want_to_delete.dart';




class CarrierListBlurDialog extends StatelessWidget {
  List<Carriers> carriers = [];
  String userUid;
  CarrierListBlurDialog(this.carriers, this.userUid);

  @override
  Widget build(BuildContext context) {
    void whenCarrierAddTapped(String documentId) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  child: AddCarrierSettingPopup(
                    userUid: userUid,
                  ),
                ),
              ),
            );
          });
    }

    carrierDelete(BuildContext context, String documentUid) {
      CarrierDeleteBlurDialog alert =
          CarrierDeleteBlurDialog(documentUid: documentUid);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Carriers List",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.56,
                              //  height: 400,
                              child: ListView.builder(
                                  itemCount: carriers.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.56,
                                      child: ListView.builder(
                                        itemCount: carriers.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              carrierDelete(context,
                                                  carriers[index].documentUid);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                  left: 13,
                                                  right: 13),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 31,
                                                    right: 0,
                                                    left: 0,
                                                    child: Container(
                                                      height: 44,
                                                      // color: Colors.red,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8.0,
                                                                0.0,
                                                                8.0,
                                                                0.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Container(
                                                            height: 40,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  blurRadius:
                                                                      2.0, //effect of softening the shadow
                                                                  spreadRadius:
                                                                      0.1, //effecet of extending the shadow
                                                                  offset: Offset(
                                                                      0.0, //horizontal
                                                                      3.0 //vertical
                                                                      ),
                                                                ),
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  blurRadius:
                                                                      1.0, //effect of softening the shadow
                                                                  spreadRadius:
                                                                      0.1, //effecet of extending the shadow
                                                                  offset: Offset(
                                                                      0.0, //horizontal
                                                                      -1.0 //vertical
                                                                      ),
                                                                ),
                                                              ],
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Center(
                                                              child: Marquee(
                                                                backDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            500),
                                                                directionMarguee:
                                                                    DirectionMarguee
                                                                        .oneDirection,
                                                                child: Text(
                                                                  carriers[
                                                                          index]
                                                                      .carrierPhone,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                              .grey[
                                                                          600]),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 84,
                                                    // color: Colors.red,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Container(
                                                          height: 35,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey[400],
                                                                blurRadius:
                                                                    2.0, //effect of softening the shadow
                                                                spreadRadius:
                                                                    0.1, //effecet of extending the shadow
                                                                offset: Offset(
                                                                    0.0, //horizontal
                                                                    3.0 //vertical
                                                                    ),
                                                              ),
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey[400],
                                                                blurRadius:
                                                                    1.0, //effect of softening the shadow
                                                                spreadRadius:
                                                                    0.1, //effecet of extending the shadow
                                                                offset: Offset(
                                                                    0.0, //horizontal
                                                                    -1.0 //vertical
                                                                    ),
                                                              ),
                                                            ],
                                                            color: Colors
                                                                .orange[100],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Center(
                                                            child: Marquee(
                                                              backDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          500),
                                                              directionMarguee:
                                                                  DirectionMarguee
                                                                      .oneDirection,
                                                              child: Text(
                                                                carriers[index]
                                                                    .carrierName,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  })),
                        ),
                      ],
                    ),
                    Positioned(
                      /////////////////////////////// close button
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          )),
                    ),
                    Positioned(
                      ///////////////////////////////convex effect for close button
                      top: 0.0,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 18.0,
                            color: Colors.grey,
                          ),
                          decoration: ConcaveDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              colors: [
                                Colors.white,
                                Colors.grey[700],
                              ],
                              depression: 4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    whenCarrierAddTapped(userUid);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Icon(Icons.add, color: Colors.orange[500], size: 40),
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
