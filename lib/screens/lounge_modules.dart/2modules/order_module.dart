
import 'package:flutter/material.dart';

import '../orders/my_orders_screen.dart';
class OrderModule extends StatefulWidget {
  @override
  _OrderModuleState createState() => _OrderModuleState();
}

class _OrderModuleState extends State<OrderModule> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: MyOrdersScreen(),
    );
  }
}