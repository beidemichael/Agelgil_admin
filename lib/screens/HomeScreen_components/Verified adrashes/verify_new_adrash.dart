import 'package:agelgil_admin_end/model/Models.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/Add%20Kushna/kushna_result.dart';
import 'package:agelgil_admin_end/screens/HomeScreen_components/Verified adrashes/carrier_result.dart';
import 'package:agelgil_admin_end/service/database.dart';
import 'package:agelgil_admin_end/shared/background_blur.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../maps.dart';

class VerifyNewAdrash extends StatefulWidget {
  @override
  _VerifyNewAdrashState createState() => _VerifyNewAdrashState();
}

class _VerifyNewAdrashState extends State<VerifyNewAdrash> {
  final _formKey = GlobalKey<FormState>();
  String phoneCode = "+251";
  String phoneNumber = "";
  String wholePhoneNumber = "";
  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });
  }

  carrierResult(
    BuildContext context,
  ) {
    CarrierResultBlurDialog alert = CarrierResultBlurDialog();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamProvider<List<Carriers>>.value(
            value: DatabaseService(phoneNumber: wholePhoneNumber).verifyNewAdrash,
            child: alert);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundBlur(),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 100),
              child: Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey[400])),
                                  ////////////////////////////////

                                  ///when textfield is selected//////////////////////////
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      borderSide: BorderSide(
                                          color: Colors.orange[200])),
                                  ////////////////////////////////////////
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
