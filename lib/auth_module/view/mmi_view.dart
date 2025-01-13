import 'package:flutter/material.dart';
import 'dart:math' as math;

class MarketMoodIndexPage extends StatefulWidget {
  const MarketMoodIndexPage({Key? key}) : super(key: key);

  @override
  _MarketMoodIndexPageState createState() => _MarketMoodIndexPageState();
}

class _MarketMoodIndexPageState extends State<MarketMoodIndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double value = 47.54;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: value).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Mood Index'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Know what\'s the sentiment on the street today',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Market Mood Index',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 300,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: MoodMeterPainter(value: _animation.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  _animation.value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                );
              },
            ),
            const Text(
              'Updated 5 minutes ago',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodMeterPainter extends CustomPainter {
  final double value;

  MoodMeterPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Draw the background arcs
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    void drawArc(double startAngle, double sweepAngle, Color color, double fillPercentage) {
      paint.color = color.withOpacity(0.2);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * math.pi / 180,
        sweepAngle * math.pi / 180,
        false,
        paint,
      );

      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * math.pi / 180,
        sweepAngle * math.pi / 180 * fillPercentage,
        false,
        paint,
      );
    }

    // Calculate fill percentages
    double extremeFearFill = math.min(1.0, math.max(0.0, value / 30));
    double fearFill = math.min(1.0, math.max(0.0, (value - 30) / 20));
    double greedFill = math.min(1.0, math.max(0.0, (value - 50) / 20));
    double extremeGreedFill = math.min(1.0, math.max(0.0, (value - 70) / 30));

    // Draw arcs
    drawArc(150, 60, Colors.green, extremeFearFill);
    drawArc(210, 60, Colors.orange, fearFill);
    drawArc(270, 60, Colors.red.shade300, greedFill);
    drawArc(330, 60, Colors.red, extremeGreedFill);

    // Draw the needle
    if (value > 0) {
      final needlePaint = Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.fill;

      final needleLength = radius * 0.8;
      final angle = (150 + (value * 240 / 100)) * math.pi / 180;
      final needleEnd = Offset(
        center.dx + needleLength * math.cos(angle),
        center.dy + needleLength * math.sin(angle),
      );

      // Draw needle
      canvas.drawLine(
          center,
          needleEnd,
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 3);

      // Draw center circle
      canvas.drawCircle(center, 10, needlePaint);
    }

    // Draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    void drawText(String text, double angle, Color color) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      final labelRadius = radius * 1.2;
      final x = center.dx + labelRadius * math.cos(angle * math.pi / 180);
      final y = center.dy + labelRadius * math.sin(angle * math.pi / 180);
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    drawText('EXTREME\nFEAR', 180, Colors.green);
    drawText('FEAR', 240, Colors.orange);
    drawText('GREED', 300, Colors.red.shade300);
    drawText('EXTREME\nGREED', 360, Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
