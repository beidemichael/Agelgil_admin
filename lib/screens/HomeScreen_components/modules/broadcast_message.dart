import 'dart:math';

import 'package:agelgil_admin_end/screens/lounge_modules.dart/widgets/toggle_button.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';

import 'package:agelgil_admin_end/model/Models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'Broadcast widget/are_you_sure_you_want_to_broadcast.dart';

class BroadcastMessage extends StatefulWidget {
  @override
  _BroadcastMessageState createState() => _BroadcastMessageState();
}

class _BroadcastMessageState extends State<BroadcastMessage> {
  String title = '';
  String body = '';
  int _radioValue = 6;
  String type = '';
  bool customButtonActivated = false;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
      print(_radioValue);
    });
  }

  areYouSureYouBroadCast(
      BuildContext context, String title, String body, String type) {
    BroadCastBlurDialog alert =
        BroadCastBlurDialog(title: title, body: body, type: type);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_radioValue != 4) {
      setState(() {
        customButtonActivated = false;
      });
    }
    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height - 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600],
                        blurRadius: 1.0, //effect of softening the shadow
                        spreadRadius: 0.5, //effecet of extending the shadow
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Title',
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
                                  title = val;
                                });
                              },
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // labelText: 'Type title here.',
                                focusColor: Colors.orange[900],
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15.0,
                                    color: Colors.grey[800]),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                        BorderSide(color: Colors.orange[200])),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Body',
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
                                  body = val;
                                });
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                // labelText: 'Type body here.',
                                focusColor: Colors.orange[900],
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15.0,
                                    color: Colors.grey[800]),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.orange[200])),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Radio(
                            activeColor: Colors.orange[500],
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            'User',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          new Radio(
                            activeColor: Colors.orange[500],
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            'Adrash',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          new Radio(
                            activeColor: Colors.orange[500],
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            'Kushna',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _radioValue = 4;
                            customButtonActivated = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 120,
                              height: 50,
                              child: Center(
                                child: Text('Custom',
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100)),
                              ),
                              decoration: BoxDecoration(
                                  color: customButtonActivated == false
                                      ? Colors.grey
                                      : Colors.orange,
                                  borderRadius: BorderRadius.circular(35.0))),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          if (_radioValue == 0) {
                            print('User');
                            setState(() {
                              type = 'User';
                            });
                          } else if (_radioValue == 1) {
                            print('Adrash');
                            setState(() {
                              type = 'Adrash';
                            });
                          } else if (_radioValue == 2) {
                            print('Kushna');
                            setState(() {
                              type = 'Kushna';
                            });
                          }

                          areYouSureYouBroadCast(context, title, body, type);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 120,
                              height: 50,
                              child: Center(
                                child: Text('Send',
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100)),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(35.0))),
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
