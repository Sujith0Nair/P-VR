import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialBar extends StatefulWidget {
  RadialBar(this.currentProgress, this.type);
  double currentProgress;
  String type;
  @override
  _RadialBarState createState() => _RadialBarState();
}

class _RadialBarState extends State<RadialBar>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  double progressDegrees = 0;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.currentProgress * _progressAnimation.value;
        });
      });
    _radialProgressAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 100,
        width: 100,
        padding: EdgeInsets.all(20),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.type,
                style:
                    TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                height: 2.0,
                width: 20.0,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                " " + (widget.currentProgress * 100).toString() + "%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progressDegrees),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;
  RadialPainter(this.progressInDegrees);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.purpleAccent])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
