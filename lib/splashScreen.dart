import 'dart:async';

import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Center(
        child: Text(
          'P-VR',
          style: TextStyle(
              color: Colors.orange,
              fontFamily: "Poppins",
              fontSize: 35,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
