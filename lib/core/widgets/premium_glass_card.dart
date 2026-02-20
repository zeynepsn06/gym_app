import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PremiumGlassCard extends StatelessWidget {
  final Widget child;
  final double width;
  final EdgeInsets padding;
  final double borderRadius; // ✅ EKLENDİ

  const PremiumGlassCard({
    super.key,
    required this.child,
    this.width = 380,
    this.padding = const EdgeInsets.all(32),
    this.borderRadius = 26, // ✅ EKLENDİ
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // ✅
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius), // ✅
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.glassStrong.withAlpha((0.65 * 255).round()),
                AppColors.glass.withAlpha((0.4 * 255).round()),
              ],
            ),
            border: Border.all(
              color: AppColors.primaryGlow.withAlpha((0.35 * 255).round()),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGlow.withAlpha((0.25 * 255).round()),
                blurRadius: 50,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withAlpha((0.35 * 255).round()),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
