import 'package:agelgil_admin_end/screens/HomeScreen_components/Adrash%20progress/complete_orders.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Verified adrashes/verify_new_adrash.dart';
import '../../../model/Models.dart';
import '../../../shared/background_blur.dart';
import 'are_you_sure_you_want_to_unverify.dart';

class VerifiedAdrash extends StatefulWidget {
  @override
  _VerifiedAdrashState createState() => _VerifiedAdrashState();
}

class _VerifiedAdrashState extends State<VerifiedAdrash> {
  areYouSureYouWantUnverify(
      BuildContext context, String documentId, String name) {
    UnverifyBlurDialog alert =
        UnverifyBlurDialog(documentId: documentId, name: name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final adrashes = Provider.of<List<Carriers>>(context) ?? [];
    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          adrashes == null
              ? Center(
                  child: SpinKitCircle(
                  color: Colors.orange,
                  size: 50.0,
                ))
              : SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 110,
                        child: adrashes.isNotEmpty
                            ? ListView.builder(
                                itemCount: adrashes.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 20, right: 20),
                                    child: GestureDetector(
                                      onTap: (){
                                         Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => MultiProvider(
                                                providers: [
                                                  StreamProvider<
                                                      List<Orders>>.value(
                                                    value: DatabaseService(
                                                            userUid:
                                                                adrashes[
                                                                        index]
                                                                    .carrierUid)
                                                        .adrashProgress,
                                                  ),
                                                ],
                                                child: AdrashCompleteOrders(),
                                              ),
                                            ));
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
                                                top: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    areYouSureYouWantUnverify(
                                                        context,
                                                        adrashes[index]
                                                            .documentUid,
                                                        adrashes[index]
                                                            .carrierName);
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.timesCircle,
                                                    size: 25.0,
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                                Positioned(
                                                bottom: 14,
                                                right: 8,
                                                child: GestureDetector(
                                                  onTap: () {
                                                  launch("tel://${adrashes[index].carrierPhone}");
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .phoneAlt,
                                                    size: 23.0,
                                                    color: Colors.green[300],
                                                  ),
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
                                                    Text(
                                                        adrashes[index]
                                                            .carrierName,
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.grey[500],
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                    Text(
                                                        adrashes[index]
                                                            .carrierPhone,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.grey[400],
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
                                    "No verified Adrashs",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerifyNewAdrash(),
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: Center(
                              child: Text('Add',
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100)),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(35.0),
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
