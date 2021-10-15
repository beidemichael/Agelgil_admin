
import 'package:agelgil_admin_end/model/Models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';

import 'complete_order_list_dialog.dart';


class CompleteMyOrdersCard extends StatefulWidget {
  Orders orders;
  CompleteMyOrdersCard({this.orders});
  @override
  _CompleteMyOrdersCardState createState() => _CompleteMyOrdersCardState();
}

class _CompleteMyOrdersCardState extends State<CompleteMyOrdersCard> {
  List food = [];
  List price = [];
  List quantity = [];
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      food = widget.orders.food;
      price = widget.orders.price;
      quantity = widget.orders.quantity;
    });
  }

  _orderList(BuildContext context) {
    CompleteOrderListBlurryDialog alert = CompleteOrderListBlurryDialog(widget.orders);

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

  HyphenDevider() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Column(
          children: [
            Container(
              height: 145,
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
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                                  fontSize: 20,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 55,
                        // color: Colors.yellow[50],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Orderd items',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w300)),
                            Text(widget.orders.quantity.length.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 55,
                        // color: Colors.blue[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w300)),
                            Text(widget.orders.subTotal.toString() + '0 Birr',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              SizedBox(height: 3.0),
               Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text( 'Delivery time: '+
                    convertTimeStampDifference(
                            widget.orders.delivered.millisecondsSinceEpoch-widget.orders.created.millisecondsSinceEpoch)
                        .toString(),
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('Adrash: '+ widget.orders.carrierName,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                    convertTimeStamp(
                            widget.orders.created.millisecondsSinceEpoch)
                        .toString(),
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String convertTimeStamp(timeStamp) {
//Pass the epoch server time and the it will format it for you
    String formatted = formatTime(timeStamp).toString();
    return formatted;
  }

String convertTimeStampDifference(timeStamp) {
//Pass the epoch server time and the it will format it for you
    String formatted = formatTimeDifference(timeStamp).toString();
    return formatted;
  }

  String formatTimeDifference(int timestamp) {
  /// The number of milliseconds that have passed since the timestamp
  int difference =timestamp;
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

  return !result.startsWith("J") ? result : result; 
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

  GreyContainerFront() {
    return Column(
      children: <Widget>[
        Container(
          height: 145,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
            color: Colors.grey[50],
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
          height: 70,
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
          height: 145,
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
          height: 70,
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
