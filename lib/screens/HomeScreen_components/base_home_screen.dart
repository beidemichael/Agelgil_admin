import 'package:agelgil_admin_end/screens/HomeScreen_components/Kushnas/kushnas.dart';
import 'package:flutter/material.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/Add%20Kushna/add_kushna.dart';
import 'package:provider/provider.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'Authorized adrashes (Takers)/autorized_adrash.dart';
import 'modules/all_controllers.dart';
import 'maps.dart';
import 'package:agelgil_admin_end/model/Models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/modules/all_orders.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/modules/all_users.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/Verified%20adrashes/verified_adrash.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/modules/broadcast_message.dart';
import 'Adrash progress/enter_adrash_phone.dart';

class HomeBaseScreen extends StatefulWidget {
  @override
  _HomeBaseScreenState createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          ListView(
            children: [
              Container(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.green[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.plusCircle,
                                size: 25.0, color: Colors.green[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Register Kushnas',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<Lounges>>.value(
                            value: DatabaseService().lounges, child: Kushnas()
                            // child: Maps(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.orange[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.utensils,
                                size: 25.0, color: Colors.orange[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Kushnas',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Divider(
                  color: Colors.grey[700],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<Orders>>.value(
                              value: DatabaseService().allorders,
                              child: AllOrders(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.red[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.conciergeBell,
                                size: 25.0, color: Colors.red[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Orders',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<UserInfo>>.value(
                              value: DatabaseService().allUsers,
                              child: AllUsers(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.blue[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.users,
                                size: 25.0, color: Colors.blue[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Users',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Divider(
                  color: Colors.grey[700],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<Controller>>.value(
                              value: DatabaseService().allController,
                              child: AllController(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.purple[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.gamepad,
                                size: 25.0, color: Colors.purple[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Controller',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.purple[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BroadcastMessage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.yellow[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.bullhorn,
                                size: 21.0, color: Colors.yellow[800]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Broadcast message',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.yellow[800],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Divider(
                  color: Colors.grey[700],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EnterAdrashPhone()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.blueGrey[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.wallet,
                                size: 25.0, color: Colors.blueGrey[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Adrash Progress',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueGrey[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<Carriers>>.value(
                              value: DatabaseService().verifiedAdrashed,
                              child: VerifiedAdrash(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.brown[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.certificate,
                                size: 25.0, color: Colors.brown[500]),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Verified Adrash',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.brown[500],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StreamProvider<List<Carriers>>.value(
                              value: DatabaseService().authorizedAdrashed,
                              child: AuthorizedAdrash(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Stack(
                    children: [
                      ConvexShadow(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(FontAwesomeIcons.crown,
                                size: 25.0, color: Colors.grey[700]),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Text('Authorized Adrash',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600)),
                                Text(' (Takers)',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ConvexShadow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700],
            blurRadius: 15.0, //effect of softening the shadow
            spreadRadius: 1.0, //effecet of extending the shadow
            offset: Offset(
              7.0, //horizontal
              7.0, //vertical
            ),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 10.0, //effect of softening the shadow
            spreadRadius: 1.0, //effecet of extending the shadow
            offset: Offset(
              -7.0, //horizontal
              -7.0, //vertical
            ),
          ),
        ],
        color: Color(0xffecece4),
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
