import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lounge_screen.dart';

class LoungeHomeScreen extends StatefulWidget {
  String userUid = '';

  LoungeHomeScreen({this.userUid});
  @override
  _LoungeHomeScreenState createState() => _LoungeHomeScreenState();
}

class _LoungeHomeScreenState extends State<LoungeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MultiProvider(
            providers: [
          StreamProvider<List<Carriers>>.value(
            value: DatabaseService(loungeId: widget.userUid).loungeCarriers,
          ),
          StreamProvider<List<Orders>>.value(
            value: DatabaseService(loungeId: widget.userUid).orders,
          ),
          StreamProvider<List<Lounges>>.value(
            value: DatabaseService(
              userUid: widget.userUid,
            ).lounge,
          )
        ],
            child: LoungeScreen(
              userUid: widget.userUid,
            )));
  }
}
