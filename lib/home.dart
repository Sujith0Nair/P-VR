import 'dart:convert';

import 'package:flutter/material.dart';
import 'controller.dart';
import 'handsfree.dart';
import 'info.dart';
import 'joystick.dart';
import 'radialbar.dart';
import 'settings.dart';
import 'styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              _backgroundCover(),
              _greetings(),
              _statusHolder(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlineButton(
                    textColor: darkColor,
                    borderSide: BorderSide(
                      width: 2,
                      color: darkColor,
                    ),
                    color: darkColor,
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Controller()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Text(
                      'Controller Mode',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlineButton(
                    textColor: darkColor,
                    borderSide: BorderSide(
                      width: 2,
                      color: darkColor,
                    ),
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HandsFree()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Text(
                      'Handsfree Mode',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Settings()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              gradient: purpleGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JoyStick()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              gradient: purpleGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.videogame_asset,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Info()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              gradient: purpleGradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _backgroundCover() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        gradient: purpleGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Positioned _greetings() {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.04,
      top: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RadialBar(0.8, "CPU"),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          RadialBar(0.8, "Temp"),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          RadialBar(0.8, "Mem")
        ],
      ),
    );
  }

  Positioned _statusHolder() {
    return Positioned(
      top: MediaQuery.of(context).size.height * .30,
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ]),
        child: StatusIndicator(),
      ),
    );
  }
}

class StatusIndicator extends StatefulWidget {
  @override
  _StatusIndicatorState createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Device Status:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: darkColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Connected',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.lightGreen,
            ),
          )
        ],
      ),
    );
  }
}
