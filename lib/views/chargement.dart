import 'package:flutter/material.dart';
import 'package:mywellbeing/views/Chargement.dart';
import 'dart:math'; 
import 'package:mywellbeing/views/Acceuil.dart';
class Chargement extends StatefulWidget {
  const Chargement({super.key});

  @override
  State<Chargement> createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    );
    _navigateToHomePage();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  _navigateToHomePage() async {
    await Future.delayed(Duration(seconds: 3), () {}); // Simule un délai de chargement
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Acceuil()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Nous arrangons tout a votre convenance. Patientez',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, 
              ),
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(100, 100),
                  painter: BubblePainter(animationValue: _animationController!.value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final double animationValue;

  BubblePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    double radius = size.width / 10;
    for (int i = 0; i < 8; i++) {
      double angle = (i / 8) * 2 * 3.14;
      double x = size.width / 2 + radius * 4 * animationValue * cos(angle);
      double y = size.height / 2 + radius * 4 * animationValue * sin(angle);
      paint.color = Colors.blueAccent.withOpacity((1 - animationValue) * 0.5 + 0.5);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
