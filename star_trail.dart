// Author: Lakshman Turlapati
// Description: A Flutter widget that creates a star trails animation effect with circular motion,
//              fading inner radii, and shorter trails near the center.

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarTrail Animation',
      theme: ThemeData.dark(),
      home: const StarTrail(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StarTrail extends StatefulWidget {
  const StarTrail({super.key});

  @override
  State<StarTrail> createState() => _StarTrailState();
}

class _StarTrailState extends State<StarTrail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  final int numberOfStars = 250;
  final Random _random = Random();
  Offset _rotationCenter = Offset.zero;

  @override
  void initState() {
    super.initState();
    _stars = _generateStars(numberOfStars, const Size(1000, 600));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 180),
    )..repeat();
  }

  List<Star> _generateStars(int count, Size estimatedSize) {
    final generationCenter = Offset(estimatedSize.width * 0.3, estimatedSize.height * 0.3);
    final maxRadius = (max(generationCenter.dx, generationCenter.dy) +
            max(estimatedSize.width - generationCenter.dx, estimatedSize.height - generationCenter.dy)) *
        0.8;

    return List.generate(count, (index) {
      final radiusDistribution = _random.nextDouble();
      final radius = pow(radiusDistribution, 2.0) * maxRadius * 0.72 + 15.0;
      final initialAngle = _random.nextDouble() * 2 * pi;

      // Calculate relative radius and fade factor for inner 10%
      final relRadius = radius / maxRadius;
      final fadeFactor = relRadius < 0.1 ? relRadius / 0.1 : 1.0;

      final speed = 1.0;

      // Calculate trail length and adjust based on fade factor
      double trailLength = 0.05 + _random.nextDouble() * 0.35;
      trailLength *= fadeFactor; // Smaller trails for inner stars

      // Calculate opacity and adjust based on fade factor
      double opacity = 0.3 + _random.nextDouble() * 0.6;
      if (_random.nextDouble() > 0.6) {
        opacity *= 0.5;
      }
      opacity *= fadeFactor; // Greater fade (more transparent) for inner stars

      // Determine star color with adjusted opacity
      final colorVariation = _random.nextInt(100);
      Color color;
      if (colorVariation < 80) {
        color = Colors.white.withOpacity(opacity);
      } else if (colorVariation < 95) {
        color = Color.lerp(Colors.white, Colors.lightBlue.shade100, 0.5)!
            .withOpacity(opacity * 0.8);
      } else {
        color = Color.lerp(Colors.white, Colors.yellow.shade100, 0.4)!
            .withOpacity(opacity * 0.8);
      }

      final strokeWidth = (0.4 + _random.nextDouble() * 0.8) * (opacity / 0.9);

      return Star(
        radius: radius,
        initialAngle: initialAngle,
        speed: speed,
        trailLength: trailLength,
        color: color,
        strokeWidth: strokeWidth,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _rotationCenter = Offset(size.width * 0.3, size.height * 0.3);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF02040a), Color(0xFF0a0a14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: StarTrailPainter(
                stars: _stars,
                animationValue: _controller.value,
                rotationCenter: _rotationCenter,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Star {
  final double radius;
  final double initialAngle;
  final double speed;
  final double trailLength;
  final Color color;
  final double strokeWidth;

  Star({
    required this.radius,
    required this.initialAngle,
    required this.speed,
    required this.trailLength,
    required this.color,
    required this.strokeWidth,
  });
}

class StarTrailPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;
  final Offset rotationCenter;

  StarTrailPainter({
    required this.stars,
    required this.animationValue,
    required this.rotationCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final totalAngleOffset = animationValue * 2 * pi;

    for (final star in stars) {
      paint.color = star.color;
      paint.strokeWidth = star.strokeWidth;

      final currentEndAngle = star.initialAngle + (star.speed * totalAngleOffset);
      final startAngle = currentEndAngle - star.trailLength;

      final rect = Rect.fromCircle(
        center: rotationCenter,
        radius: star.radius,
      );

      final sweepAngle = min(star.trailLength, 2 * pi * 0.99);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarTrailPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.rotationCenter != rotationCenter;
  }
}