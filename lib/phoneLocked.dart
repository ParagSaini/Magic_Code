import 'package:flutter/material.dart';
import 'package:magiccode/emergencyCall.dart';
import 'dart:async';

import 'package:magiccode/forgotPasswordScreen.dart';

class PhoneLocked extends StatefulWidget {
  static int numberOfTime = 0;
  @override
  _PhoneLockedState createState() => _PhoneLockedState();
}

class _PhoneLockedState extends State<PhoneLocked> {
  int seconds = 30 * PhoneLocked.numberOfTime;
  Timer _timer;
  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      seconds--;
      setState(() {});
      if (seconds == 0) {
        _timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Phonelocked.png'),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 295.0,
                left: 108.0,
                child: Text(
                  'Try again in $seconds seconds',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.5,
                    fontFamily: 'TuckerScript',
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 50.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Container(
                    height: 30.0,
                    width: 150.0,
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                left: 1.0,
                bottom: 50.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmergencyCall()));
                  },
                  child: Container(
                    height: 40.0,
                    width: 100.0,
                    color: Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
