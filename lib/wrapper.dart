import 'dart:async';
import 'dart:io';

import 'package:agelgil_admin_end/screens/signin/signIn.dart';
import 'package:agelgil_admin_end/shared/internet_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/base_home_screen.dart';
import 'package:agelgil_admin_end/screens/Before_homescreen/fingerprint_check.dart';
import 'model/Models.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isInternetConnected = true;
  StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          isInternetConnected = true;
        });
      } else {
        setState(() {
          isInternetConnected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth>(context);
    bool userVerified;
    if(user!=null){
 if (user.uid == 'tVpD76IBivhsUAQ8NjYSwAxGubE3') {
      setState(() {
        userVerified = true;
      });
    }
    if (user.uid == 'LuPgJeDLVSVmdTrvCz2BTlxk4qz2') {
      setState(() {
        userVerified = true;
      });
    }
    if (user.uid == 'gWrTAv7YalZ9dJXElQ73dtqMRYf2') {
      setState(() {
        userVerified = true;
      });
    }
    }
   
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: user == null
                ? SignIn()
                : userVerified == true
                    ? 
                    FingerPrintCheck()
                   
                    : Container(
                        child: Center(
                          child: Text('You are not registered.',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Visibility(
                visible: !isInternetConnected, child: InternetConnectivity()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }
}
