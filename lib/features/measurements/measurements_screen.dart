import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Vücut Ölçüleri",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Summary Cards
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSummaryCard("Boy", "180", "cm"),
                    const SizedBox(width: 16),
                    _buildSummaryCard("Kilo", "78.5", "kg"),
                    const SizedBox(width: 16),
                    _buildSummaryCard("Yağ Oranı", "%14", ""),
                    const SizedBox(width: 16),
                    _buildSummaryCard("BMI", "24.2", ""),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              const Text(
                "Detaylı Ölçümler",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _buildMeasurementGroup("Üst Vücut", [
                {"label": "Omuz", "value": "120 cm"},
                {"label": "Göğüs", "value": "105 cm"},
                {"label": "Sol Kol", "value": "38 cm"},
                {"label": "Sağ Kol", "value": "38.5 cm"},
              ]),

              const SizedBox(height: 16),

              _buildMeasurementGroup("Orta Bölge", [
                {"label": "Bel", "value": "82 cm"},
                {"label": "Karın", "value": "85 cm"},
              ]),

              const SizedBox(height: 16),

              _buildMeasurementGroup("Alt Vücut", [
                {"label": "Kalça", "value": "98 cm"},
                {"label": "Uyluk", "value": "58 cm"},
                {"label": "Baldır", "value": "40 cm"},
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, String unit) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 110,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(26),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(26)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white.withAlpha(179), fontSize: 12),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: " $unit",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementGroup(String title, List<Map<String, String>> items) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(26)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["label"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      item["value"]!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

