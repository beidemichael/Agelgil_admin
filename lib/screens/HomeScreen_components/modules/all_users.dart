import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';

import 'package:agelgil_admin_end/model/Models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  double userQuantity;
  List<UserInfo> listForEachDate;
  List<List<UserInfo>> listOfDateLists;
  int max = 0;
  String dropdownValue = 'Day';
  var items = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  totalCalculation(List<UserInfo> allUsers) {
    userQuantity = 0;
    for (int i = 0; i < allUsers.length; i++) {
      userQuantity = userQuantity + 1;
    }
  }

  calculation(List<UserInfo> allUsers) {
    listOfDateLists = [];
    listForEachDate = [];
    //Make sure that there are documents within firebase
    if (allUsers.length != 0) {
      //Adding the first document manually so that
      //the forloop section has something to compare dates
      //This listForEachDate is for storing a collection
      //of all documents of one date
      listForEachDate = [allUsers[0]];
      //listOfDateLists is a list of all listForEachDate
      //This gives us a list of lists with the documents
      //separated by date i.e.
      //[[date1, date1], [date2], [date3, date3, date3], etc]
      listOfDateLists = [];

      //i = 1 because index 0 already added above
      for (int i = 1; i < allUsers.length; i++) {
        DateTime myDateTimei = allUsers[i].created.toDate();
        DateTime myDateTimei_1 = allUsers[i - 1].created.toDate();
        var myDateTimeii = DateFormat.yMd().format(myDateTimei);
        var myDateTimeii_1 = DateFormat.yMd().format(myDateTimei_1);
        if (dropdownValue == 'Day') {
          myDateTimeii = DateFormat.yMd().format(myDateTimei);
          myDateTimeii_1 = DateFormat.yMd().format(myDateTimei_1);
        } else if (dropdownValue == 'Week') {
          myDateTimeii = DateFormat.d().format(myDateTimei);
          if (int.parse(myDateTimeii) >= 1 && int.parse(myDateTimeii) <= 7) {
            myDateTimeii = '1';
          } else if (int.parse(myDateTimeii) >= 8 &&
              int.parse(myDateTimeii) <= 14) {
            myDateTimeii = '2';
          } else if (int.parse(myDateTimeii) >= 15 &&
              int.parse(myDateTimeii) <= 21) {
            myDateTimeii = '3';
          } else if (int.parse(myDateTimeii) >= 22 &&
              int.parse(myDateTimeii) <= 31) {
            myDateTimeii = '4';
          }
          myDateTimeii_1 = DateFormat.d().format(myDateTimei_1);
          if (int.parse(myDateTimeii_1) >= 1 &&
              int.parse(myDateTimeii_1) <= 7) {
            myDateTimeii_1 = '1';
          } else if (int.parse(myDateTimeii_1) >= 8 &&
              int.parse(myDateTimeii_1) <= 14) {
            myDateTimeii_1 = '2';
          } else if (int.parse(myDateTimeii_1) >= 15 &&
              int.parse(myDateTimeii_1) <= 21) {
            myDateTimeii_1 = '3';
          } else if (int.parse(myDateTimeii_1) >= 22 &&
              int.parse(myDateTimeii_1) <= 31) {
            myDateTimeii_1 = '4';
          }
        } else if (dropdownValue == 'Month') {
          myDateTimeii = DateFormat.MMMM().format(myDateTimei);
          myDateTimeii_1 = DateFormat.MMMM().format(myDateTimei_1);
        } else if (dropdownValue == 'Year') {
          myDateTimeii = DateFormat.y().format(myDateTimei);
          myDateTimeii_1 = DateFormat.y().format(myDateTimei_1);
        }

        //If the current index's date matches that of the previous
        //index's date, then add it to the listForEachDate
        if (myDateTimeii == myDateTimeii_1) {
          listForEachDate.add(allUsers[i]);
          if (listForEachDate.length > max) {
            max = listForEachDate.length;
          }

          //If [index]date does not match [index - 1]date
          //Then add the current listForEachDate to the
          //listOfDateLists i.e. add sublist to list of lists
        } else {
          listOfDateLists.add(listForEachDate);
          //Clear the listForEachDate so that we can create
          //a new clean list of new dates
          listForEachDate = [];
          //Add the new date to the listForEachDate
          //so that the process can start again
          listForEachDate.add(allUsers[i]);
        }
      }
      //Once the document has been iterated through,
      //Add to the big list.
      listOfDateLists.add(listForEachDate);
    }
  }

  dateConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.yMMMd().format(date);
    return date_day;
  }

  weekConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.d().format(date);
    if (int.parse(date_day) >= 1 && int.parse(date_day) <= 7) {
      date_day = '1 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 8 && int.parse(date_day) <= 14) {
      date_day = '2 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 15 && int.parse(date_day) <= 21) {
      date_day = '3 ' + DateFormat.MMMM().format(date);
    } else if (int.parse(date_day) >= 22 && int.parse(date_day) <= 31) {
      date_day = '4 ' + DateFormat.MMMM().format(date);
    }
    return date_day;
  }

  monthConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.MMMM().format(date);
    return date_day;
  }

  yearConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.y().format(date);
    return date_day;
  }

  monTuesWedConversion(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    var date_day = DateFormat.E().format(date);
    return date_day;
  }

  @override
  Widget build(BuildContext context) {
    final allUsers = Provider.of<List<UserInfo>>(context) ?? [];
    totalCalculation(allUsers);
    calculation(allUsers);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundBlur(),
            allUsers == null
                ? Center(
                    child: SpinKitCircle(
                    color: Colors.orange,
                    size: 50.0,
                  ))
                : allUsers.length == 0
                    ? Center(
                        child: SpinKitCircle(
                        color: Colors.orange,
                        size: 50.0,
                      ))
                    : Column(
                        children: [
                          Container(
                            height: 50,
                            child: DropdownButton(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.orange),
                              underline: Container(
                                height: 2,
                                color: Colors.orange,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  max = 0;
                                });
                              },
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                            ),
                          ),
                          Container(
                            child: allUsers.isEmpty
                                ? Center(
                                    child: Text(
                                        'You don\'t have any users yet.',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w600)),
                                  )
                                : Center(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              206,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: listOfDateLists.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 60,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      bottom: 0.0,
                                                      top: 0.0,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  blurRadius:
                                                                      5.0, //effect of softening the shadow
                                                                  spreadRadius:
                                                                      0.1, //effecet of extending the shadow
                                                                  offset: Offset(
                                                                      0.0, //horizontal
                                                                      3.0 //vertical
                                                                      ),
                                                                ),
                                                              ],
                                                              color: Colors
                                                                  .orange[200],
                                                              // color:listOfDateLists[
                                                              //               index]
                                                              //           .length<10? Colors.green[200]:listOfDateLists[
                                                              //               index]
                                                              //           .length<25?Colors.yellow[200]:Colors.red[200],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: ((listOfDateLists[
                                                                            index]
                                                                        .length /
                                                                    max) *
                                                                ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) -
                                                                    100)),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  blurRadius:
                                                                      5.0, //effect of softening the shadow
                                                                  spreadRadius:
                                                                      0.1, //effecet of extending the shadow
                                                                  offset: Offset(
                                                                      0.0, //horizontal
                                                                      3.0 //vertical
                                                                      ),
                                                                ),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                              ),
                                                              color: Colors
                                                                  .orange[200],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            color:
                                                                Colors.red[200],
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              dropdownValue=='Day'?
                                                              monTuesWedConversion(
                                                                    listOfDateLists[
                                                                            index]
                                                                        .first
                                                                        .created)
                                                                .toString()
                                                                :''
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            color: Colors
                                                                .grey[200],
                                                          ),
                                                          child: Center(
                                                            child: Text(dropdownValue ==
                                                                    'Day'
                                                                ? dateConversion(listOfDateLists[
                                                                            index]
                                                                        .first
                                                                        .created)
                                                                    .toString()
                                                                : dropdownValue ==
                                                                        'Week'
                                                                    ? weekConversion(listOfDateLists[index]
                                                                            .first
                                                                            .created)
                                                                        .toString()
                                                                    : dropdownValue ==
                                                                            'Month'
                                                                        ? monthConversion(listOfDateLists[index].first.created)
                                                                            .toString()
                                                                        : yearConversion(listOfDateLists[index].first.created)
                                                                            .toString()),
                                                          ),
                                                        ),
                                                        Text(listOfDateLists[
                                                                index]
                                                            .length
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10, bottom: 10),
                            child: Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width,
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
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0)),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('User Quantity',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.grey[500],
                                                )),
                                            Text(
                                                userQuantity.toInt().toString(),
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700],
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
