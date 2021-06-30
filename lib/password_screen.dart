import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'phoneLocked.dart';
import 'emergencyCall.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({this.openItScreen});
  final bool openItScreen;

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with TickerProviderStateMixin {
  Color dotColor1 = Colors.grey;
  Color dotColor2 = Colors.grey;
  Color dotColor3 = Colors.grey;
  Color dotColor4 = Colors.grey;
  int dotNumber = 1;
  bool visibility = false;
  bool openIt = false;
  int numberOfWrongAttempt = 0;
  // open lock condition is : dotNumber == 5 && openIt = true;

  void onPressedButton() {
    if (dotNumber < 5) {
      setState(() {
        if (dotNumber == 1) {
          dotColor1 = Colors.white;
          controller1.forward();
          visibility = true;
        } else if (dotNumber == 2) {
          dotColor2 = Colors.white;
          controller2.forward();
        } else if (dotNumber == 3) {
          dotColor3 = Colors.white;
          controller3.forward();
        } else if (dotNumber == 4) {
          dotColor4 = Colors.white;
          controller4.forward();
        }
      });

      if (dotNumber == 1) {
        setState(() {
          visibility = true;
        });
      }
      dotNumber++;
    }
    if (dotNumber == 5) {
      if (openIt || widget.openItScreen) {
        SystemNavigator.pop();
      } else {
        Vibration.vibrate(duration: 250);
        controllerHorAhead1.forward();
        controllerHorAhead2.forward();
        controllerHorAhead3.forward();
        controllerHorAhead4.forward();
        dotNumber = 1;
        setState(() {
          dotColor1 = Colors.grey;
          dotColor2 = Colors.grey;
          dotColor3 = Colors.grey;
          dotColor4 = Colors.grey;
          visibility = false;
        });
        numberOfWrongAttempt++;
        if (numberOfWrongAttempt >= 5) {
          PhoneLocked.numberOfTime++;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PhoneLocked()));
        }
      }
    }
  }

  void onDeletePress() {
    setState(() {
      if (dotNumber == 2) {
        dotColor1 = Colors.grey;
        visibility = false;
      } else if (dotNumber == 3) {
        dotColor2 = Colors.grey;
      } else if (dotNumber == 4) {
        dotColor3 = Colors.grey;
      } else if (dotNumber == 5) {
        dotColor4 = Colors.grey;
      }
    });

    dotNumber--;
  }

  void onLongPress() {
    openIt = true;
    Vibration.vibrate(duration: 150);
  }

  void onEmergencyPressed() {
//    openIt = true;
//    Vibration.vibrate(duration: 150);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EmergencyCall()));
  }

  void onDeletePressed() {
//    openIt = true;
//    Vibration.vibrate(duration: 150);
    if (visibility == true) {
      onDeletePress();
    } else {
//      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      Navigator.pop(context);
    }
  }

  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  AnimationController controller4;

  AnimationController controllerHorAhead1;
  AnimationController controllerHorBack1;
  AnimationController controllerHorAhead2;
  AnimationController controllerHorBack2;
  AnimationController controllerHorAhead3;
  AnimationController controllerHorBack3;
  AnimationController controllerHorAhead4;
  AnimationController controllerHorBack4;

  Animation animation1;
  Animation animation2;
  Animation animation3;
  Animation animation4;

  Animation animationHorAhead1;
  Animation animationHorBack1;
  Animation animationHorAhead2;
  Animation animationHorBack2;
  Animation animationHorAhead3;
  Animation animationHorBack3;
  Animation animationHorAhead4;
  Animation animationHorBack4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([]);

    controller1 = AnimationController(
      duration: Duration(milliseconds: 10),
      vsync: this,
    );
    controller2 = AnimationController(
      duration: Duration(milliseconds: 10),
      vsync: this,
    );
    controller3 = AnimationController(
      duration: Duration(milliseconds: 10),
      vsync: this,
    );
    controller4 = AnimationController(
      duration: Duration(milliseconds: 10),
      vsync: this,
    );

    controllerHorAhead1 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorBack1 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorAhead2 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorBack2 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorAhead3 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorBack3 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorAhead4 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );
    controllerHorBack4 = AnimationController(
      duration: Duration(microseconds: 100),
      vsync: this,
    );

    animation1 = Tween<double>(begin: 3.0, end: 25.0).animate(controller1);
    animation2 = Tween<double>(begin: 3.0, end: 25.0).animate(controller2);
    animation3 = Tween<double>(begin: 3.0, end: 25.0).animate(controller3);
    animation4 = Tween<double>(begin: 3.0, end: 25.0).animate(controller4);

    animationHorAhead1 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorAhead1);
    animationHorBack1 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorBack1);
    animationHorAhead2 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorAhead2);
    animationHorBack2 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorBack2);
    animationHorAhead3 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorAhead3);
    animationHorBack3 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorBack3);
    animationHorAhead4 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorAhead4);
    animationHorBack4 =
        Tween<double>(begin: 0.0, end: 22).animate(controllerHorBack4);

    controller1.addListener(() {
      setState(() {});
    });
    controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller1.reverse(from: 25.0);
      }
    });
    controller2.addListener(() {
      setState(() {});
    });
    controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller2.reverse(from: 25.0);
      }
    });
    controller3.addListener(() {
      setState(() {});
    });
    controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller3.reverse(from: 25.0);
      }
    });
    controller4.addListener(() {
      setState(() {});
    });
    controller4.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller4.reverse(from: 25.0);
      }
    });

    controllerHorAhead1.addListener(() {
      setState(() {});
    });
    controllerHorAhead1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorAhead1.reverse(from: 22);
      } else if (status == AnimationStatus.dismissed) {
        controllerHorBack1.forward();
      }
    });
    controllerHorBack1.addListener(() {
      setState(() {});
    });
    controllerHorBack1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorBack1.reverse(from: 22);
      }
    });
    controllerHorAhead2.addListener(() {
      setState(() {});
    });
    controllerHorAhead2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorAhead2.reverse(from: 22);
      } else if (status == AnimationStatus.dismissed) {
        controllerHorBack2.forward();
      }
    });
    controllerHorBack2.addListener(() {
      setState(() {});
    });
    controllerHorBack2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorBack2.reverse(from: 22);
      }
    });
    controllerHorAhead3.addListener(() {
      setState(() {});
    });
    controllerHorAhead3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorAhead3.reverse(from: 22);
      } else if (status == AnimationStatus.dismissed) {
        controllerHorBack3.forward();
      }
    });
    controllerHorBack3.addListener(() {
      setState(() {});
    });
    controllerHorBack3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorBack3.reverse(from: 22);
      }
    });
    controllerHorAhead4.addListener(() {
      setState(() {});
    });
    controllerHorAhead4.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorAhead4.reverse(from: 22);
      } else if (status == AnimationStatus.dismissed) {
        controllerHorBack4.forward();
      }
    });
    controllerHorBack4.addListener(() {
      setState(() {});
    });
    controllerHorBack4.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerHorBack4.reverse(from: 22);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/BackgroundImage1.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 246.0,
              left: 112.0 + animationHorAhead1.value - animationHorBack1.value,
              child: CircleAvatar(
                backgroundColor: dotColor1,
                radius: animation1.value,
              ),
            ),
            Positioned(
              top: 246.0,
              left: 112.0 +
                  44.0 +
                  animationHorAhead2.value -
                  animationHorBack2.value,
              child: CircleAvatar(
                backgroundColor: dotColor2,
                radius: animation2.value,
              ),
            ),
            Positioned(
              top: 246.0,
              left: 112.0 +
                  87.0 +
                  animationHorAhead3.value -
                  animationHorBack3.value,
              child: CircleAvatar(
                backgroundColor: dotColor3,
                radius: animation3.value,
              ),
            ),
            Positioned(
              top: 246.0,
              left: 112.0 +
                  87.0 +
                  43.0 +
                  animationHorAhead4.value -
                  animationHorBack4.value,
              child: CircleAvatar(
                backgroundColor: dotColor4,
                radius: animation4.value,
              ),
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(37.0, 295.0, 217.0, 260.0),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin:
                  EdgeInsets.fromLTRB(37.0 + 96.0, 295.0, 217.0 - 96.0, 260.0),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0 + 96.0 + 96.0, 295.0, 217.0 - 96.0 - 96.0, 260.0),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(37.0, 385.0 - 30, 217.0, 260.0 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0 + 96, 385.0 - 30, 217.0 - 96, 260.0 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0 + 96 + 96, 385.0 - 30, 217.0 - 96 - 96, 260.0 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0, 385.0 + 90 - 55, 217.0, 260.0 - 90 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0 + 96.0, 385.0 + 90 - 55, 217.0 - 96.0, 260.0 - 90 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(37.0 + 96.0 + 96, 385.0 + 90 - 55,
                  217.0 - 96.0 - 96.0, 260.0 - 90 - 90),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            DigitWidget(
              margin: EdgeInsets.fromLTRB(
                  37.0 + 96.0,
                  385.0 + 90 - 55 + 90 - 30,
                  217.0 - 96.0 - 96.0,
                  260.0 - 90 - 90 - 5),
              onPressed: onPressedButton,
              onLongPress: onLongPress,
            ),
            Visibility(
              visible: visibility,
              child: DeleteContainer(),
            ),
            EmergencyButton(
              onPressed: onEmergencyPressed,
            ),
            DeleteButton(
              onDeletePressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  EmergencyButton({this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 533.0,
      bottom: 0.0,
      left: 20.0,
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        child: Container(
          height: 30.0,
          width: 100.0,
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  DeleteButton({this.onDeletePressed});
  final Function onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 533.0,
      bottom: 0.0,
      left: 200.0,
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onDeletePressed,
        child: Container(
          height: 30.0,
          width: 100.0,
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class DeleteContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 44.0,
      left: 225.0,
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/deleteImage.png'),
          ),
        ),
      ),
    );
  }
}

class DigitWidget extends StatelessWidget {
  DigitWidget({this.margin, this.onPressed, this.onLongPress});
  final EdgeInsets margin;
  final Function onPressed;
  final Function onLongPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: 96.0,
      margin: margin,
      child: RawMaterialButton(
        shape: CircleBorder(),
        onPressed: onPressed,
        onLongPress: onLongPress,
      ),
    );
  }
}
