import 'package:flutter/material.dart';
import 'package:magiccode/emergencyCall.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/forgotPassword.png'),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 45.0,
              top: 378.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 120.0,
                  height: 45.0,
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              left: 1.0,
              bottom: 50.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EmergencyCall()));
                },
                child: Container(
                  width: 120.0,
                  height: 45.0,
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
