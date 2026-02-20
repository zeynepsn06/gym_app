import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;

  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background/app_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
        Positioned(
          top: -120,
          left: -120,
          child: _glowCircle(260),
        ),
        Positioned(
          bottom: -140,
          right: -100,
          child: _glowCircle(300),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(color: Colors.transparent),
        ),
        Container(
          color: Colors.black.withOpacity(0.25),
        ),
        child,
      ],
    );
  }

  Widget _glowCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primaryGlow.withOpacity(0.35),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
