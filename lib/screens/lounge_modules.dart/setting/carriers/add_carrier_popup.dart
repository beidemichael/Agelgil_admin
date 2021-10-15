import 'dart:math';


import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';



import 'package:provider/provider.dart';

import '../../../HomeScreen_components/Add Kushna/kushna_result.dart';

class AddCarrierSettingPopup extends StatefulWidget {
  String userUid;

  AddCarrierSettingPopup({
    this.userUid,
  });
  @override
  _AddCarrierSettingPopupState createState() => _AddCarrierSettingPopupState();
}

class _AddCarrierSettingPopupState extends State<AddCarrierSettingPopup> {
  final _formKey = GlobalKey<FormState>();
  String newName;
  int newIndex;
  String userUid;

  String phoneCode = "+251";
  String phoneNumber = "";
  String wholePhoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userUid = widget.userUid;
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: " + countryCode.toString());
  }

  carrierResult(
    BuildContext context,
  ) {
    CarrierResultListBlurDialog alert =
        CarrierResultListBlurDialog(userUid: widget.userUid);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamProvider<List<Carriers>>.value(
            value: DatabaseService(userPhoneNumber: wholePhoneNumber).carriers,
            child: alert);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add carrier",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              SizedBox(
                height: 35.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: '+251',
                      favorite: ['+251', 'ETH'],
                      textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                      showFlag: true,
                      showFlagDialog: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                          // decorationColor: Colors.white,
                          ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),

                        //Label Text/////////////////////////////////////////////////////////
                        labelText: 'Enter Phone Number',
                        // labelText: Texts.PHONE_NUMBER_LOGIN,
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                            color: Colors.grey[800]),
                        /* hintStyle: TextStyle(
                                  color: Colors.orange[900]
                                  ) */
                        ///////////////////////////////////////////////

                        //when it's not selected////////////////////////////
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.grey[400])),
                        ////////////////////////////////

                        ///when textfield is selected//////////////////////////
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.orange[200])),
                        ////////////////////////////////////////
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: Center(
                      child: Text('Cancel',
                          style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w100)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(35.0))),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    wholePhoneNumber = " ";
                    wholePhoneNumber = phoneCode + phoneNumber.trim();

                    carrierResult(context);
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: Center(
                      child: Text('Search',
                          style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w100)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(35.0))),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
