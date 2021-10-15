import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

import '../../shared/background_blur.dart';
import '../HomeScreen_components/base_home_screen.dart';

class FingerPrintCheck extends StatefulWidget {
  @override
  _FingerPrintCheckState createState() => _FingerPrintCheckState();
}

class _FingerPrintCheckState extends State<FingerPrintCheck> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _message = "Not Authorized";
  bool authenticated = false;
  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print(canCheckBiometrics);
    return canCheckBiometrics;
  }

  Future<void> _authenticateMe() async {
// 8. this method opens a dialog for fingerprint authentication.
//    we do not need to create a dialog nut it popsup from device natively.

    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Confirm fingerprint to continue to Agelgil Admin.", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
      setState(() {
        _message = authenticated ? "Authorized" : "Not Authorized";
      });
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  @override
  void initState() {
    checkingForBioMetrics();
    _authenticateMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundBlur(),
        authenticated == true
            ? HomeBaseScreen()
            : GestureDetector(
                onTap: () {
                  _authenticateMe();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Icon(FontAwesomeIcons.fingerprint,
                        size: 100.0, color: Colors.orange[500]),
                  ),
                ),
              ),
      ],
    );
  }
}
