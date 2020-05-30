import 'package:flutter/material.dart';
import 'socketHandlers.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController raspberryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (
          AppBar(
            title: const Text('Settings'),
          )
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Wifi on/off'),
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              ListTile(
                title: Text('Bluetooth on/off'),
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              ListTile(
                title: Text('IP Address of Device'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextField(
                    controller: raspberryController,
                    decoration: new InputDecoration.collapsed(
                      hintText: '192.168.15.1',
                    ),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  color: Color(0xff4A64FE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    SocketHandlers().connectToRaspTank(
                      raspberryController.text,
                    );
                  },
                  child: Text(
                    'Connect',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
