import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class JoyStick extends StatefulWidget {
  @override
  _JoyStickState createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  void _onVerticalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.up) {
        print('Swiped up!');
        Vibration.vibrate(duration: 100, amplitude: 100);
        moveForward();
      } else {
        print('Swiped down!');
        Vibration.vibrate(duration: 100, amplitude: 100);
        moveBackward();
      }
    });
  }

  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.left) {
        print('Swiped left!');
        Vibration.vibrate(duration: 100, amplitude: 100);
        moveLeft();
      } else {
        print('Swiped right!');
        Vibration.vibrate(duration: 100, amplitude: 100);
        moveRight();
      }
    });
  }

  Socket socket;
  bool isMoving;
  String message;
  @override
  void initState() {
    connectController();
    isMoving = false;
    super.initState();
  }

  Future connectController() async {
    socket =
        await Socket.connect('192.168.43.104', 10223).catchError((onError) {
      print(onError.toString());
    });
    print("Socket Address: ${socket.address.toString()}");
    while (true) {
      socket.listen((onData) {
        String message = utf8.decode(onData);
        print("Message Received: $message");
      });
    }
  }

  void movement() {
    while (isMoving) {
      socket.write(message);
    }
  }

  void moveForward() {
    if (isMoving) {
      message = "forward";
    } else {
      isMoving = true;
      message = "forward";
      movement();
    }
  }

  void moveBackward() {
    if (isMoving) {
      message = "backward";
    } else {
      isMoving = true;
      message = "backward";
      movement();
    }
  }

  void moveLeft() {
    if (isMoving) {
      message = "left";
    } else {
      isMoving = true;
      message = "left";
      movement();
    }
  }

  void moveRight() {
    if (isMoving) {
      message = "right";
    } else {
      isMoving = true;
      message = "right";
      movement();
    }
  }

  void stopMoving1() {
    socket.write("DS");
  }

  void stopMoving2() {
    socket.write("TS");
  }

  void headup() {
    socket.write("headup");
  }

  void headdown() {
    socket.write("headdown");
  }

  void reset() {
    socket.write("headhome");
  }

  void _onTap() {
    isMoving = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joystick Simulator'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                          child: Text('data'),
                        ),
                      );
                    });
              }),
        ],
      ),
      body: SimpleGestureDetector(
        onVerticalSwipe: _onVerticalSwipe,
        onHorizontalSwipe: _onHorizontalSwipe,
        onTap: _onTap,
        swipeConfig: SimpleSwipeConfig(
          verticalThreshold: 40.0,
          horizontalThreshold: 40.0,
          swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
        ),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
