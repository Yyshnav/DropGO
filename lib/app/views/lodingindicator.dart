import 'package:flutter/material.dart';
// import 'dart:math' as math;

class DeliveryBikeLoader extends StatefulWidget {
  const DeliveryBikeLoader({super.key});

  @override
  State<DeliveryBikeLoader> createState() => _DeliveryBikeLoaderState();
}

class _DeliveryBikeLoaderState extends State<DeliveryBikeLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _suspension;
  late Animation<double> _roadAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _suspension = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 3.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 3.0, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _roadAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 100,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Road line moving effect
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _roadAnim,
                  builder: (_, __) => CustomPaint(
                    painter: _RoadPainter(offset: _roadAnim.value),
                    child: const SizedBox(height: 2),
                  ),
                ),
              ),

              // Lamp post
              Positioned(
                bottom: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _roadAnim,
                  builder: (_, __) => Transform.translate(
                    offset: Offset(-350 * _roadAnim.value, 0),
                    child: const Icon(Icons.light, size: 90, color: Colors.black87),
                  ),
                ),
              ),

              // Bike image with suspension
              AnimatedBuilder(
                animation: _suspension,
                builder: (_, __) => Transform.translate(
                  offset: Offset(0, _suspension.value),
                  child: Image.asset(
                    'assets/images/fi_9561688.png', 
                    width: 130,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoadPainter extends CustomPainter {
  final double offset;

  _RoadPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF282828)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);

    // White dash 1
    final dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(size.width * 0.5 - offset * size.width, 0),
        Offset(size.width * 0.5 - offset * size.width + 20, 0), dashPaint);

    // White dash 2
    canvas.drawLine(Offset(size.width * 0.35 - offset * size.width, 0),
        Offset(size.width * 0.35 - offset * size.width + 10, 0), dashPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
