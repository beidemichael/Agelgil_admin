import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/screens/lounge_modules.dart/orders/order_list_dialog.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'are_you_sure_you_want_to_cancel.dart';
import 'are_you_sure_you_want_to_set_delivered.dart';
import 'carrier_list_dialog.dart';
import 'user_notification.dart';

class MyOrdersCard extends StatefulWidget {
  Orders orders;
  MyOrdersCard({this.orders});
  @override
  _MyOrdersCardState createState() => _MyOrdersCardState();
}

class _MyOrdersCardState extends State<MyOrdersCard> {
  List food = [];
  List price = [];
  List quantity = [];
  DateTime now;
  bool loading = true;
  void initState() {
    super.initState();
    timeNow();
    Future.delayed(Duration(milliseconds: 500), () {
      food = widget.orders.food;
      price = widget.orders.price;
      quantity = widget.orders.quantity;
    });
  }

  timeNow() async {
    now = await NTP.now();
    setState(() {
      loading = false;
    });
  }

  _orderList(BuildContext context) {
    OrderListBlurryDialog alert = OrderListBlurryDialog(widget.orders);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  carrierList(
    BuildContext context,
    List carriers,
    String documentId,
  ) {
    CarrierOrderListBlurDialog alert =
        CarrierOrderListBlurDialog(carriers, documentId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  areYouSureYouWantToCancel(BuildContext context, String documentId) {
    CancelOrderBlurDialog alert = CancelOrderBlurDialog(
      documentId: documentId,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  areYouSureYouWantToSetDelivered(BuildContext context, String documentId) {
    SetDeliveredBlurDialog alert = SetDeliveredBlurDialog(
      documentId: documentId,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _orderList(context);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              areYouSureYouWantToCancel(
                                  context, widget.orders.documentId);
                            },
                            child: CancelOrder()),
                        GestureDetector(
                            onTap: () {
                              areYouSureYouWantToSetDelivered(
                                  context, widget.orders.documentId);
                            },
                            child: Delivered()),
                        RedContainerBackShadow(),
                        GreyContainerFront(),
                        TextsAndContent(),
                        HyphenDevider(),
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

  CancelOrder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(color: Colors.transparent, height: 760),
            Container(
              width: 150,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 5.0,
                    spreadRadius: 0.1,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Delete order',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Delivered() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(color: Colors.transparent, height: 760),
            Container(
              width: 150,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 5.0,
                    spreadRadius: 0.1,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Delivered',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  HyphenDevider() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Column(
          children: [
            Container(
              height: 290,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 22,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Flex(
                          children: List.generate(
                            (MediaQuery.of(context).size.width / 10).floor(),
                            (index) => Container(
                              height: 1,
                              width: 5,
                              color: Colors.grey[500],
                            ),
                          ),
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween);
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextsAndContent() {
    void whenUserNotifyClicked() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: UserNotification(userToken: widget.orders.userToken,),
                ),
              ),
            );
          });
    }

    return Column(
      children: <Widget>[
        // SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                // color: Colors.green[200],
                child: Center(
                  child: Marquee(
                    backDuration: Duration(milliseconds: 500),
                    directionMarguee: DirectionMarguee.oneDirection,
                    child: Text(widget.orders.loungeName.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        // color: Colors.yellow[200],
                        child: Center(
                          child: Icon(FontAwesomeIcons.hotel,
                              size: 10.0, color: Colors.grey[200]),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 22,
                            width: 30,
                            decoration: BoxDecoration(
                                // color: Colors.red[50],
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Flex(
                                        children: List.generate(
                                          (3).floor(),
                                          (index) => Container(
                                            height: 1,
                                            width: 5,
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                        direction: Axis.horizontal,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween);
                                  },
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 7.0),
                            child: Center(
                              child: Icon(FontAwesomeIcons.conciergeBell,
                                  size: 7.0, color: Colors.grey[200]),
                            ),
                          ),
                          Container(
                            height: 22,
                            width: 30,
                            decoration: BoxDecoration(
                                // color: Colors.red[50],
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Flex(
                                        children: List.generate(
                                          (3).floor(),
                                          (index) => Container(
                                            height: 1,
                                            width: 5,
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                        direction: Axis.horizontal,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween);
                                  },
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 22,
                        width: 22,
                        // color: Colors.yellow[200],
                        child: Center(
                          child: Icon(FontAwesomeIcons.houseUser,
                              size: 10.0, color: Colors.grey[200]),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Delivery status',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w400)),
                        Text(
                            !widget.orders.isTaken
                                ? 'Waiting...'
                                : 'On the way',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300)),
                        Marquee(
                          backDuration: Duration(milliseconds: 400),
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(widget.orders.userName,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300)),
                        Text(widget.orders.userPhone,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 125,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Orderd items',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[500],
                            )),
                        Text(widget.orders.quantity.length.toString(),
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Subtotal',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[500],
                            )),
                        Text(widget.orders.subTotal.toString() + '0 Birr',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Service charge',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[500],
                            )),
                        Text(widget.orders.serviceCharge.toString() + '0 Birr',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.grey[700],
                            )),
                        Text(
                            (widget.orders.subTotal +
                                        widget.orders.serviceCharge)
                                    .toString() +
                                '0 Birr',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                // carrierList(context, carriers, widget.orders.documentId);
              },
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: widget.orders.loungeOrderNumber,
                    color: Colors.grey[800],
                    drawText: false,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(new ClipboardData(
                    text: widget.orders.userPhone +
                        '\n${widget.orders.information}'));
                final snackBar = SnackBar(
                  content: Text('User info copied to clipboard.'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.orders.userPhone,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 10),
                      Text(widget.orders.information,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 10,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Adrash: ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600)),
                        Text(widget.orders.carrierName,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch("tel://${widget.orders.carrierphone}");
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.phone,
                              size: 25.0, color: Colors.green[600]),
                          SizedBox(width: 20),
                          Text('CALL ADRASH',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green[600],
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch("tel://${widget.orders.userPhone}");
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.phone,
                              size: 25.0, color: Colors.orange[600]),
                          SizedBox(width: 20),
                          Text('CALL USER',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange[600],
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                whenUserNotifyClicked();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bell,
                              size: 25.0, color: Colors.yellow[800]),
                          SizedBox(width: 20),
                          Text('NOTIFY USER',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellow[800],
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: loading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.orange,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey[300],
                        ),
                        value: 0.8,
                      ),
                    )
                  : Text(
                      convertTimeStampp(
                              widget.orders.created.millisecondsSinceEpoch)
                          .toString(),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ],
    );
  }

  String convertTimeStampp(timeStamp) {
//Pass the epoch server time and the it will format it for you

    String formatted = formatTime(timeStamp).toString();
    return formatted;
  }

  String formatTime(int timestamp) {
    /// The number of milliseconds that have passed since the timestamp
    int difference = now.millisecondsSinceEpoch - timestamp;
    String result;

    if (difference < 60000) {
      result = countSeconds(difference);
    } else if (difference < 3600000) {
      result = countMinutes(difference);
    } else if (difference < 86400000) {
      result = countHours(difference);
    } else if (difference < 604800000) {
      result = countDays(difference);
    } else if (difference / 1000 < 2419200) {
      result = countWeeks(difference);
    } else if (difference / 1000 < 31536000) {
      result = countMonths(difference);
    } else
      result = countYears(difference);

    return !result.startsWith("J") ? result + ' ago' : result;
  }

  /// Converts the time difference to a number of seconds.
  /// This function truncates to the lowest second.
  ///   returns ("Just now" OR "X seconds")
  String countSeconds(int difference) {
    int count = (difference / 1000).truncate();
    return count > 1 ? count.toString() + ' seconds' : 'Just now';
  }

  /// Converts the time difference to a number of minutes.
  /// This function truncates to the lowest minute.
  ///   returns ("1 minute" OR "X minutes")
  String countMinutes(int difference) {
    int count = (difference / 60000).truncate();
    return count.toString() + (count > 1 ? ' minutes' : ' minute');
  }

  /// Converts the time difference to a number of hours.
  /// This function truncates to the lowest hour.
  ///   returns ("1 hour" OR "X hours")
  String countHours(int difference) {
    int count = (difference / 3600000).truncate();
    return count.toString() + (count > 1 ? ' hours' : ' hour');
  }

  /// Converts the time difference to a number of days.
  /// This function truncates to the lowest day.
  ///   returns ("1 day" OR "X days")
  String countDays(int difference) {
    int count = (difference / 86400000).truncate();
    return count.toString() + (count > 1 ? ' days' : ' day');
  }

  /// Converts the time difference to a number of weeks.
  /// This function truncates to the lowest week.
  ///   returns ("1 week" OR "X weeks" OR "1 month")
  String countWeeks(int difference) {
    int count = (difference / 604800000).truncate();
    if (count > 3) {
      return '1 month';
    }
    return count.toString() + (count > 1 ? ' weeks' : ' week');
  }

  /// Converts the time difference to a number of months.
  /// This function rounds to the nearest month.
  ///   returns ("1 month" OR "X months" OR "1 year")
  String countMonths(int difference) {
    int count = (difference / 2628003000).round();
    count = count > 0 ? count : 1;
    if (count > 12) {
      return '1 year';
    }
    return count.toString() + (count > 1 ? ' months' : ' month');
  }

  /// Converts the time difference to a number of years.
  /// This function truncates to the lowest year.
  ///   returns ("1 year" OR "X years")
  String countYears(int difference) {
    int count = (difference / 31536000000).truncate();
    return count.toString() + (count > 1 ? ' years' : ' year');
  }

//   String convertTimeStamp(timeStamp) {
// //Pass the epoch server time and the it will format it for you
//     String formatted = formatTime(timeStamp).toString();
//     return formatted;
//   }

  GreyContainerFront() {
    return Column(
      children: <Widget>[
        Container(
          height: 290,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
            color: Colors.grey[50],
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                color: widget.orders.isTaken == false
                    ? Colors.orange[500]
                    : Colors.grey[500],
              ),
            ),
          ),
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey[50], BlendMode.srcOut),
          child: Stack(
            children: <Widget>[
              Container(
                height: 22,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.dstOut,
                  color: Colors.grey[100],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 22,
                  width: 11,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 22,
                  width: 11,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 480,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }

  RedContainerBackShadow() {
    return Column(
      children: <Widget>[
        Container(
          height: 290,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                blurRadius: 5.0, //effect of softening the shadow
                spreadRadius: 0.1, //effecet of extending the shadow
                offset: Offset(
                    0.0, //horizontal
                    3.0 //vertical
                    ),
              ),
            ],
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Container(
            height: 22,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 5.0, //effect of softening the shadow
                  spreadRadius: 0.1, //effecet of extending the shadow
                  offset: Offset(
                      0.0, //horizontal
                      3.0 //vertical
                      ),
                ),
              ],
              // color: Colors.grey[400],
            ),
          ),
        ),
        Container(
          height: 480,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                blurRadius: 5.0, //effect of softening the shadow
                spreadRadius: 0.1, //effecet of extending the shadow
                offset: Offset(
                    0.0, //horizontal
                    3.0 //vertical
                    ),
              ),
            ],
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}
