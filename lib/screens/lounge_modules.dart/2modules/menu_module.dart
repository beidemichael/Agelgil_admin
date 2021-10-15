import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../menu/menus.dart';

class MenuModule extends StatefulWidget {
  List category = [];
  String name;
  int categoryItems;
  String userUid;
  MenuModule({this.category, this.categoryItems, this.name, this.userUid});
  @override
  _MenuModuleState createState() => _MenuModuleState();
}

class _MenuModuleState extends State<MenuModule> {
  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: StreamProvider<List<Menu>>.value(
        value: DatabaseService(userUid: widget.userUid).menu,
        child: Menus(
          categoryItems: widget.category,
          loungeName: widget.name,
          categoryList: widget.categoryItems,
          userUid: widget.userUid,
        ),
      ),
    );
  }
}
