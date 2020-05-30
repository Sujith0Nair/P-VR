import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (
          AppBar(
            title: const Text('Info'),
          )
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Connected Device info:'),
              ),
              Image(
                image: AssetImage('assets/images/raspberrypi.png'),
              ),
              ListTile(
                title: Text('Name: Rasptank'),
              ),
              ListTile(
                title: Text('OS: Raspbian'),
              ),
              ListTile(
                title: Text('Version: 12.2.3'),
              ),
              ListTile(
                title: Text('Python Version: 3.7'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
