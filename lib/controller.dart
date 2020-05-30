import 'package:flutter/material.dart';
import 'socketHandlers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rasp Video Feed'),
      ),
      body: WebView(
        initialUrl: 'http://' + SocketHandlers().ipAddress + '',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
