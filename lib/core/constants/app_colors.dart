import 'package:flutter/material.dart';

class AppColors {
  // ================== BRAND & ACCENTS ==================
  static const Color primary = Color(0xFF4DA3FF);
  static const Color primaryGlow = Color.fromRGBO(77, 163, 255, 0.3);
  static const Color primaryLight = Color(0xFF80BFFF);
  static const Color accent = Color(0xFF00E5FF);
  static const Color glow = primary;
  
  
  // ================== DARK THEME (Deep Space) ==================
  static const Color spaceDark = Color(0xFF020617);
  static const Color spaceMedium = Color(0xFF0B1220);
  static const Color spaceLight = Color(0xFF1E293B);
  
  // ================== SEMANTIC DARK ==================
  static const Color bgDark = spaceDark;
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color cardDark = Color.fromRGBO(30, 41, 59, 0.7);
  static const Color borderDark = Color.fromRGBO(255, 255, 255, 0.08);

  // ================== LIGHT THEME (Clean) ==================
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Colors.white;
  static const Color cardLight = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color borderLight = Color.fromRGBO(0, 0, 0, 0.05);

  // ================== TEXT COLORS ==================
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);

  // ================== COMPATIBILITY & OLD ALIASES ==================
  static const Color background = spaceDark;
  static const Color backgroundTop = spaceMedium;
  static const Color backgroundBottom = spaceDark;
  static const Color surface = surfaceDark;
  static const Color cardBg = Color.fromRGBO(255, 255, 255, 0.08);
  static const Color border = borderDark;
  
  static const Color textPrimary = textPrimaryDark;
  static const Color textSecondary = textSecondaryDark;
  static const Color textMuted = textSecondaryDark;

  static const Color glass = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color glassStrong = Color.fromRGBO(255, 255, 255, 0.08);
  static const Color glassBorder = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.3);
}
