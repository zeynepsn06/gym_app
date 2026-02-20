
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';



class WaterTrackerCard extends StatefulWidget {
  final int currentIntake;
  final int targetIntake;
  final Function(int) onAdd;

  const WaterTrackerCard({
    super.key,
    required this.currentIntake,
    required this.targetIntake,
    required this.onAdd,
  });

  @override
  State<WaterTrackerCard> createState() => _WaterTrackerCardState();
}

class _WaterTrackerCardState extends State<WaterTrackerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate percentage
    final double percent = (widget.currentIntake / widget.targetIntake).clamp(0.0, 1.0);


    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withAlpha(102), // 0.4
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withAlpha(20), // 0.08
          ),
        ),
        child: Stack(
          children: [
            // Water Wave Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _WavePainter(
                      animationValue: _controller.value,
                      percent: percent,
                      waterColor: Colors.blueAccent.withAlpha(51), // 0.2
                      waveColor: Colors.blueAccent.withAlpha(102), // 0.4
                    ),
                  );
                },
              ),
            ),
            
            // Glass Effect
            Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(color: Colors.transparent),
                ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.water_drop_rounded, color: Colors.blueAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Su Takibi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${widget.currentIntake}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " / ${widget.targetIntake} ml",
                              style: const TextStyle(
                                color: Colors.white60, // 0.6
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                       // Percentage text
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                         decoration: BoxDecoration(
                           color: Colors.black.withAlpha(51), // 0.2
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Text(
                          "%${(percent * 100).toInt()} Tamamlandı",
                          style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold),
                         ),
                       ),
                    ],
                  ),
                  
                  // Add Buttons
                  Row(
                    children: [
                      _buildAddButton(-200, Icons.remove),
                      const SizedBox(width: 12),
                      _buildAddButton(200, Icons.local_drink_rounded),
                      const SizedBox(width: 12),
                      _buildAddButton(500, Icons.local_cafe_rounded), 
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(int amount, IconData icon) {
    final isNegative = amount < 0;
    final displayAmount = amount.abs();
    
    return InkWell(
      onTap: () => widget.onAdd(amount),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isNegative ? Colors.red.withAlpha(26) : Colors.white.withAlpha(26), // 0.1
          shape: BoxShape.circle,
          border: Border.all(
            color: isNegative ? Colors.red.withAlpha(51) : Colors.white.withAlpha(26)
          ),
          boxShadow: [
             BoxShadow(
                color: Colors.black.withAlpha(26), // 0.1
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              color: isNegative ? Colors.redAccent : Colors.white, 
              size: 20
            ),
            const SizedBox(height: 2),
            Text(
              "${isNegative ? '-' : '+'}$displayAmount",
              style: TextStyle(
                color: isNegative ? Colors.redAccent : Colors.white70, 
                fontSize: 9,
                fontWeight: FontWeight.bold
              ), 
            ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;
  final double percent;
  final Color waterColor;
  final Color waveColor;

  _WavePainter({
    required this.animationValue,
    required this.percent,
    required this.waterColor,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (percent == 0) return;

    final paint = Paint()..style = PaintingStyle.fill;
    
    // Height of water based on percent
    final waterHeight = size.height * percent;
    // We want the water to fill from bottom up. 
    // y = size.height - waterHeight.

    final path = Path();
    
    // Wave parameters
    const waveCount = 2; // Number of full waves across width
    final waveLength = size.width / waveCount;
    const waveAmplitude = 10.0;
    
    // Shift the wave horizontally based on animation
    final dx = animationValue * waveLength * 2; 

    // Move to start point (bottom left)
    path.moveTo(0, size.height);
    // Draw line up to water level start
    // We need to draw the top sine wave
    
    // We construct the path for the top surface
    final baseHeight = size.height - waterHeight;

    path.moveTo(0, baseHeight);

    for (double x = 0; x <= size.width; x++) {
      final y = sin(((x + dx) * 2 * pi) / waveLength) * waveAmplitude + baseHeight;
      path.lineTo(x, y);
    }
    
    // Close path down to bottom right, then bottom left
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    paint.color = waterColor;
    canvas.drawPath(path, paint);
    
    // Second wave (slightly offset for depth)
    final path2 = Path();
    final dx2 = animationValue * waveLength * 1.5 + 50; 
    
    path2.moveTo(0, baseHeight);
    for (double x = 0; x <= size.width; x++) {
       final y = sin(((x + dx2) * 2 * pi) / waveLength) * (waveAmplitude * 0.8) + baseHeight;
       path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    
    paint.color = waveColor;
    canvas.drawPath(path2, paint);

  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.percent != percent;
  }
}
