import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'socketHandlers.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HandsFree extends StatefulWidget {
  @override
  _HandsFreeState createState() => _HandsFreeState();
}

class _HandsFreeState extends State<HandsFree> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";

  bool isMoving;
  String message;

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
    connectController();
    isMoving = false;
  }

  Future connectController() async {
    while (true) {
      SocketHandlers().raspTankSocket.listen((onData) {
        String message = utf8.decode(onData);
        print("Message Received: $message");
      });
    }
  }

  void movement() {
    while (isMoving) {
      SocketHandlers().raspTankSocket.write(message);
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
    SocketHandlers().raspTankSocket.write("DS");
  }

  void stopMoving2() {
    SocketHandlers().raspTankSocket.write("TS");
  }

  void headup() {
    SocketHandlers().raspTankSocket.write("headup");
  }

  void headdown() {
    SocketHandlers().raspTankSocket.write("headdown");
  }

  void reset() {
    SocketHandlers().raspTankSocket.write("headhome");
  }

  void stop() {
    isMoving = false;
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));
    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));
    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler(
        (String result) => setState(() => _isListening = false));
    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result));
  }

  void callFunctions(String result) {
    if (result.toLowerCase().contains('move') ||
        result.toLowerCase().contains('start') ||
        result.toLowerCase().contains('forward')) {
      moveForward();
    }
    if (result.toLowerCase().contains('stop') ||
        result.toLowerCase().contains('halt') ||
        result.toLowerCase().contains('wait')) {
      stop();
    }
    if (result.toLowerCase().contains('back') ||
        result.toLowerCase().contains('reverse')) {
      moveBackward();
    }
    if (result.toLowerCase().contains('left')) {
      moveLeft();
    }
    if (result.toLowerCase().contains('right')) {
      moveRight();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'http://' + SocketHandlers().ipAddress + '',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isAvailable && !_isListening)
            _speechRecognition.listen(locale: "en_IN").then((result) {
              print(result);
              callFunctions(result);
            });
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
