import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  List faqs = [
    {
      "title": "How to connect to a raspberry pi?",
      "steps": [
        "• Go to settings page",
        "• Enter the raspberry pi IP address",
        "• Press on CONNECT",
      ]
    },
    {
      "title": "How to connect to a streaming network?",
      "steps": [
        "• Go to settings page",
        "• Enter the stream client website address",
        "• Go to stream controller stream / hands free stream page to watch your stream",
      ]
    },
    {
      "title": "What do controller button do?",
      "steps": [
        "• Once controller button is pressed, the page immediately directs to website where the stream is being held",
        "• Note: In this option you are expected to be controlling the robot with the controller separately through Bluetooth or Wi-Fi. Also, once stream starts you need to have your mobile device in an HMD",
        "• Go to stream controller stream / hands free stream page to watch your stream",
      ]
    },
    {
      "title": "What do Hands Free button do?",
      "steps": [
        "• Hands free option controls the robot using your voice and head rotation",
        "• Once you are in this mode, insert your mobile device into the HMD",
        "• Follow the instructions provided on your screen",
        "• Rotate your head left or right to move your robot left / right respectively",
        "• Move the robot forward by saying Move / Start / Go",
        "• Stop the robot by saying Stop / Halt / Wait",
        "• Move the robot backwards by saying Back / Reverse"
      ]
    },
    {
      "title": "What does the joystick icon-ed button do?",
      "steps": [
        "• Clicking on that icon will open the joystick controls",
        "• Left half of screen is to control the forward and backward movement of the robot",
        "• Right half of the screen is to control the left and right movement of the robot",
      ]
    },
    {
      "title": "What is info page?",
      "steps": [
        "• Info page provides you with the basic information of the connected device Troubleshoot: Device not getting connected!",
        "• The App follows a TCP protocol for a healthy communication",
        "• Make sure your robot is programmed to communicate through a TCP socket",
        "• Make sure your robot’s IP address is entered correctly Troubleshoot: The stream is not in binocular view!",
        "• Flutter currently does not support VR",
        "• The VR vision are the changes in the stream from the server itself",
        "• Currently the app does not convert a normal stream into VR stream",
        "• Make sure the VR stream is uploaded from server itself",
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff4A64FE),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  showBottom(context, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff201F22).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 80,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        faqs[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showBottom(context, int index) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Color(0xff4A64FE),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: ListView.builder(
                itemCount: faqs[index]['steps'].length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                      faqs[index]['steps'][i],
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
