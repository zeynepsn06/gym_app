import 'dart:ui';
import 'package:flutter/material.dart';

class HydrationScreen extends StatefulWidget {
  const HydrationScreen({super.key});

  @override
  State<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> {
  int _currentWater = 0;
  final int _waterGoal = 2500; // 2.5 Liters

  void _addWater(int amount) {
    setState(() {
      _currentWater += amount;
      if (_currentWater > _waterGoal * 1.5) {
        _currentWater = (_waterGoal * 1.5).toInt(); // Cap at 150%
      }
    });
  }

  void _removeWater(int amount) {
    setState(() {
      if (_currentWater >= amount) {
        _currentWater -= amount;
      } else {
        _currentWater = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = _currentWater / _waterGoal;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Su Takibi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Main Circular Indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: CircularProgressIndicator(
                      value: progress > 1.0 ? 1.0 : progress,
                      backgroundColor: Colors.white.withAlpha(26),
                      color: Colors.blueAccent,
                      strokeWidth: 20,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.water_drop, size: 48, color: Colors.blueAccent.withAlpha(204)),
                      const SizedBox(height: 8),
                      Text(
                        "${(_currentWater / 1000).toStringAsFixed(1)}L",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Hedef: ${(_waterGoal / 1000).toStringAsFixed(1)}L",
                        style: TextStyle(
                          color: Colors.white.withAlpha(153),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 50),

              // Controls
              _buildGlassCard(
                child: Column(
                  children: [
                    const Text(
                      "Hızlı Ekle",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildWaterButton(200, Icons.local_cafe_outlined),
                        _buildWaterButton(500, Icons.local_drink_outlined), // Bottle icon alternative
                      ],
                    ),
                    const SizedBox(height: 20),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         IconButton(
                          onPressed: () => _removeWater(200),
                          icon: const Icon(Icons.remove, color: Colors.redAccent),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.redAccent.withAlpha(51),
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton.icon(
                          onPressed: () {
                             setState(() {
                               _currentWater = 0;
                             });
                          }, 
                          icon: const Icon(Icons.refresh, color: Colors.white54), 
                          label: const Text("Sıfırla", style: TextStyle(color: Colors.white54)),
                        )
                      ],
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

  Widget _buildWaterButton(int amount, IconData icon) {
    return Column(
      children: [
        InkWell(
          onTap: () => _addWater(amount),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withAlpha(51),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueAccent.withAlpha(128)),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "+$amount ml",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withAlpha(26)),
          ),
          child: child,
        ),
      ),
    );
  }
}

