import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';
import 'are_you_sure_you_want_to_send.dart';

class UserNotification extends StatefulWidget {
  String userToken;
  UserNotification({this.userToken});
  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  String title = '';
  String body = '';
  String type = 'Custom';
  areYouSureYouWantToSend(BuildContext context) {
    SendBlurDialog alert = SendBlurDialog(
      title: title,
      body: body,
      userToken: widget.userToken,
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
    return Container(
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    // labelText: 'Type title here.',
                    focusColor: Colors.orange[900],
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15.0,
                        color: Colors.grey[800]),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.grey[400])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.orange[200])),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Body',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      body = val;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    // labelText: 'Type body here.',
                    focusColor: Colors.orange[900],
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15.0,
                        color: Colors.grey[800]),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey[400])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.orange[200])),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    areYouSureYouWantToSend(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: 50,
                      child: Center(
                        child: Text('Send',
                            style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w100)),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(35.0))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
