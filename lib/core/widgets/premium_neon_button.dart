import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PremiumNeonButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const PremiumNeonButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<PremiumNeonButton> createState() => _PremiumNeonButtonState();
}

class _PremiumNeonButtonState extends State<PremiumNeonButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.glow,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.glow.withAlpha((hover ? 0.8 * 255 : 0.4 * 255).round()),
                blurRadius: hover ? 40 : 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
