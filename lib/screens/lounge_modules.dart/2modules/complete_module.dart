import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/service/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../complete orders/complete_orders.dart';

class CompleteModule extends StatelessWidget {
  String userUid;
  CompleteModule({this.userUid});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Orders>>.value(
      value: DatabaseService(loungeId: userUid).completeOrders,
      child: CompleteOrders(),
    );
  }
}
