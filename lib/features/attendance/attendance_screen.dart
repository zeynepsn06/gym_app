import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import 'package:gym_app/core/widgets/premium_background.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Salon Girişlerim",
            style: TextStyle(color: onSurface, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildSummarySection(context),
              Expanded(child: _buildHistoryList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ocak 2026 Giriş Özeti",
            style: TextStyle(color: onSurface.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSummaryCard(context, "12", "Giriş", Icons.login_rounded),
              const SizedBox(width: 12),
              _buildSummaryCard(context, "740", "Dakika", Icons.timer_outlined),
              const SizedBox(width: 12),
              _buildSummaryCard(context, "12", "Gün", Icons.calendar_today_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String value, String label, IconData icon) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(color: onSurface, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: TextStyle(color: onSurface.withOpacity(0.5), fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final history = [
      {"date": "30 Ocak 2026", "time": "18:30", "duration": "90 dk"},
      {"date": "28 Ocak 2026", "time": "09:00", "duration": "45 dk"},
      {"date": "26 Ocak 2026", "time": "19:15", "duration": "60 dk"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: history.length,
      itemBuilder: (ctx, index) {
        final item = history[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildHistoryCard(context, item),
        );
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, String> item) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.login_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["date"]!,
                      style: TextStyle(color: onSurface, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "Giriş: ${item["time"]} • Süre: ${item["duration"]}",
                      style: TextStyle(color: onSurface.withOpacity(0.5), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: onSurface.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }
}

