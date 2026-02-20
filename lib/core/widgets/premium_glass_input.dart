import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PremiumGlassInput extends StatelessWidget {
  final String hint;
  final bool obscure;

  const PremiumGlassInput({
    super.key,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: TextField(
            obscureText: obscure,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textMuted),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
