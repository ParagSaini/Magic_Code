import 'package:flutter/material.dart';

class EmergencyCall extends StatefulWidget {
  @override
  _EmergencyCallState createState() => _EmergencyCallState();
}

class _EmergencyCallState extends State<EmergencyCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/EmergencyCall.png'),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 93.0,
              left: 110.0,
              child: Text(
                'Emergency call',
                style: TextStyle(
                  fontFamily: 'TuckerScript',
                  color: Colors.white,
                  fontSize: 23.0,
                ),
              ),
            ),
            Positioned(
              bottom: 45.0,
              left: 15.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30.0,
                  width: 70.0,
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
