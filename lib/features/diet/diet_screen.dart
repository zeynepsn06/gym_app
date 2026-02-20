import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import 'widgets/water_tracker_card.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({super.key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final int _targetCalories = 2200;
  int _consumedCalories = 1250;
  
  final int _targetProtein = 150;
  int _consumedProtein = 85;
  
  final int _targetCarbs = 250;
  int _consumedCarbs = 110;
  
  


  final int _targetFat = 70;
  int _consumedFat = 35;
  
  int _waterIntake = 0;
  final int _waterTarget = 2500;

  void _addFood(int calories, int protein, int carbs, int fat) {
    setState(() {
      _consumedCalories += calories;
      _consumedProtein += protein;
      _consumedCarbs += carbs;
      _consumedFat += fat;
    });
  }
  
  void _addWater(int amount) {
    setState(() {
      _waterIntake = (_waterIntake + amount).clamp(0, 5000);
    });
  }

  void _showAddFoodModal(String mealName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$mealName İçin Ekle",
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildQuickAddOption("Hızlı Ekle (100 kcal)", 100, 5, 10, 2),
            const SizedBox(height: 12),
             _buildQuickAddOption("Hızlı Ekle (250 kcal)", 250, 15, 20, 8),
            const SizedBox(height: 12),
             _buildQuickAddOption("Hızlı Ekle (500 kcal)", 500, 30, 45, 15),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickAddOption(String label, int cal, int p, int c, int f) {
    return InkWell(
      onTap: () {
        _addFood(cal, p, c, f);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            const Icon(Icons.add_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Diyet Listesi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Bugün",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withAlpha(26)),
                  ),
                  child: const Icon(Icons.calendar_today_rounded, color: Colors.white),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // Kalori KartÄ±
            _buildGlassCard(
              child: Row(
                children: [
                   Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: (_consumedCalories / _targetCalories).clamp(0.0, 1.0),
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withAlpha(26),
                          color: AppColors.primary,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${(_targetCalories - _consumedCalories).abs()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _consumedCalories > _targetCalories ? "Aşıldı" : "Kalan",
                            style: TextStyle(
                              color: Colors.white.withAlpha(153),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Günlük Hedef",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alınan",
                                  style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "$_consumedCalories kcal",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Hedef",
                                  style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "$_targetCalories kcal",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Makrolar
            Row(
              children: [
                Expanded(child: _buildMacroCard("Protein", _consumedProtein, _targetProtein, const Color(0xFF4DA3FF))),
                const SizedBox(width: 12),
                Expanded(child: _buildMacroCard("Karbonhidrat", _consumedCarbs, _targetCarbs, const Color(0xFFFFB74D))),
                const SizedBox(width: 12),
                Expanded(child: _buildMacroCard("YaÄŸ", _consumedFat, _targetFat, const Color(0xFFEF5350))),
              ],
            ),

            const SizedBox(height: 24),
            
            // Su HatÄ±rlatÄ±cÄ± / Water Tracker
            WaterTrackerCard(
              currentIntake: _waterIntake,
              targetIntake: _waterTarget,
              onAdd: _addWater,
            ),
            
            const SizedBox(height: 24),

            // Ã–ÄŸÃ¼nler
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ã–ÄŸÃ¼nler",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => _showAddFoodModal("Genel"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: AppColors.primary, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "Ekle",
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildMealCard("Kahvaltı", "540 kcal", [
              "Yulaf Ezmesi (100g)",
              "3 Yumurta",
              "Siyah Kahve"
            ], Icons.wb_twilight_rounded),
            
            const SizedBox(height: 16),
            
            _buildMealCard("Öğle Yemeği", "450 kcal", [
              "Izgara Tavuk (150g)",
              "Pirinç Pilavı (100g)",
              "Ayran"
            ], Icons.wb_sunny_rounded),
            
            const SizedBox(height: 16),
            
            _buildMealCard("Akşam Yemeği", "260 kcal", [
              "Ton Balıklı Salata",
              "1 Dilim Tam Buğday Ekmeği"
            ], Icons.nights_stay_rounded),

             const SizedBox(height: 16),

             _buildMealCard("Atıştırmalıklar", "-", [], Icons.coffee_rounded),

            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }
  
  Widget _buildMacroCard(String label, int value, int target, Color color) {
    return _buildGlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withAlpha(179), fontSize: 12)),
          const SizedBox(height: 8),
          Text("${value}g", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text("/", style: TextStyle(color: Colors.white.withAlpha(102), fontSize: 12)),
          Text("${target}g", style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 12)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (value / target).clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: Colors.white.withAlpha(26),
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(String title, String kcal, List<String> items, IconData icon) {
    return InkWell(
      onTap: () => _showAddFoodModal(title),
      child: _buildGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        if (items.isEmpty)
                          Text("Henüz eklenmedi", style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                if (kcal != "-")
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(kcal, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13)),
                )
                else 
                 Icon(Icons.add_circle_outline_rounded, color: Colors.white.withAlpha(77)),
              ],
            ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(128),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(item, style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 14)),
                  ],
                ),
              )),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsets? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withAlpha(102),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withAlpha(20),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

