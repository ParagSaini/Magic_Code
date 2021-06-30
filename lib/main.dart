import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:magiccode/password_screen.dart';
import 'package:battery/battery.dart';
import 'dart:async';

import 'package:vibration/vibration.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 10.0, end: 20.0).animate(controller);
    controller.addListener(() {
      print(animation.value);
      if (animation.value > 15.0) {
        controller.reset();
      }
    });
    controller.addStatusListener((status) {
      print(status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Center(
          child: RaisedButton(
            onPressed: () {
              controller.forward();
            },
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  String currentDay = '';
  String currentDate = '';
  String currentMonth = '';
  String _timeString = '';
  var _battery;
  int batteryLevel = 74;

  double value = 0.0;
  double initialDy = 0.0;
  bool radioVisible = true;
  bool cameraVisible = true;

  bool openItScreen = false;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    String time = DateFormat('hh:mm').format(dateTime);
    if (time[0] == '0') {
      return ' ${time.substring(1)}';
    } else {
      return time;
    }
  }

  void batteryInitialise() async {
    _battery = Battery();
    batteryLevel = await _battery.batteryLevel;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentDay = DateFormat('EEEE').format(DateTime.now()).toString();
    currentDate = DateFormat('d').format(DateTime.now()).toString();
    currentMonth = DateFormat('MMMM').format(DateTime.now()).toString();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    batteryInitialise();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: GestureDetector(
          onVerticalDragStart: (x) {
            setState(() {
              radioVisible = false;
              cameraVisible = false;
            });
          },
          onVerticalDragEnd: (x) async {
            Duration duration = Duration(milliseconds: 300);
            if (x.primaryVelocity < -500 && value > 80.0) {
              for (double i = value; i < 500.0; i = i + 3) {
                value = i;
                setState(() {});
                await Future.delayed(Duration(microseconds: 1));
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordScreen(
                            openItScreen: openItScreen,
                          )));

              await Future.delayed(duration);
            }
            setState(() {
              initialDy = 0.0;
              value = 0.0;
              radioVisible = true;
              cameraVisible = true;
            });
          },
          onVerticalDragUpdate: (x) {
            if (initialDy == 0.0) {
              initialDy = x.globalPosition.dy;
            } else {
              value = initialDy - x.globalPosition.dy;
              print(value);
              if (value >= 0) {
                setState(() {});
              }
            }
          },
          onLongPress: () {
            Vibration.vibrate(duration: 100);
            openItScreen = true;
          },
          onTap: () {
            Vibration.vibrate(duration: 100);
            openItScreen = true;
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/sc.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 100.0,
                  top: 85.0 - value, // this should not be greater than 85
                  child: Text(
                    _timeString,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned(
                  left: 140.0,
                  top: 157.0 - value,
                  child: Row(
                    children: <Widget>[
                      Text(
                        currentDay,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'TuckerScript',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        currentDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'TuckerScript',
                        ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        currentMonth,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'TuckerScript',
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 13.0,
                  top: 8.0,
                  child: Text(
                    batteryLevel.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Visibility(
                  visible: radioVisible,
                  child: Positioned(
                    left: 16.5,
                    bottom: 15.5,
                    child: Icon(
                      Icons.radio_button_checked,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Visibility(
                  visible: cameraVisible,
                  child: Positioned(
                    right: 16.5,
                    bottom: 15.5,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
