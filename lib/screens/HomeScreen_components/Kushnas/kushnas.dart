import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/screens/lounge_modules.dart/1mainscreen/Lounge_home_screen.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../maps.dart';

class Kushnas extends StatefulWidget {
  @override
  _KushnasState createState() => _KushnasState();
}

class _KushnasState extends State<Kushnas> {
  @override
  Widget build(BuildContext context) {
    final kushnas = Provider.of<List<Lounges>>(context) ?? [];

    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          kushnas == null
              ? Center(
                  child: SpinKitCircle(
                  color: Colors.orange,
                  size: 50.0,
                ))
              : SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, top: 10, right: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      StreamProvider<List<Lounges>>.value(
                                        value: DatabaseService().lounges,
                                        child: Maps(),
                                      )),
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Icon(FontAwesomeIcons.mapMarked,
                                  size: 25.0, color: Colors.green[500]),
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.orange,
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 120,
                        child: kushnas.isNotEmpty
                            ? ListView.builder(
                                itemCount: kushnas.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 20, right: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoungeHomeScreen(
                                                    userUid: kushnas[index].id,
                                                  )),
                                        );
                                      },
                                      child: Container(
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
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                                bottomLeft:
                                                    Radius.circular(10.0)),
                                          ),
                                          height: 100,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Switch(
                                                  value:
                                                      kushnas[index].weAreOpen,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      //  kushnas[index].weAreOpen = value;
                                                      DatabaseService(
                                                              id: kushnas[index]
                                                                  .documentId)
                                                          .updateLoungeWeAreOpen(
                                                              !kushnas[index]
                                                                  .weAreOpen);
                                                    });
                                                  },
                                                  activeTrackColor:
                                                      Colors.green[100],
                                                  activeColor: Colors.green,
                                                ),
                                              ),
                                              Positioned(
                                                left: 20,
                                                bottom: 0,
                                                top: 0,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(kushnas[index].name,
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.grey[500],
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                    Text(
                                                        kushnas[index]
                                                                    .weAreOpen ==
                                                                true
                                                            ? 'Open'
                                                            : 'Closed',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: kushnas[index]
                                                                        .weAreOpen ==
                                                                    true
                                                                ? Colors
                                                                    .green[300]
                                                                : Colors
                                                                    .grey[400],
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Center(
                                  child: Text(
                                    "No Kushnas",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
