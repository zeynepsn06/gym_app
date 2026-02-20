import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import 'package:gym_app/core/widgets/premium_background.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key});

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Navigator.canPop(context) 
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: onSurface),
                onPressed: () => Navigator.pop(context),
              )
            : null,
          title: Text(
            "Antrenman", 
            style: TextStyle(color: onSurface, fontWeight: FontWeight.bold)
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: onSurface.withAlpha(128),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(text: "Bugün"),
              Tab(text: "Programlar"),
              Tab(text: "Geçmiş"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTodayProgram(context),
            _buildProgramList(context),
            _buildPastWorkouts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayProgram(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final List<Map<String, dynamic>> exercises = [
      {"name": "Chest Press", "sets": 3, "reps": "12-15", "weight": "40kg"},
      {"name": "Lat Pulldown", "sets": 3, "reps": "12", "weight": "45kg"},
      {"name": "Shoulder Press", "sets": 3, "reps": "12", "weight": "20kg"},
      {"name": "Leg Extension", "sets": 4, "reps": "15", "weight": "50kg"},
      {"name": "Plank", "sets": 3, "reps": "45sn", "weight": "Vücut Ağırlığı"},
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildGlassCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bugünün Antrenmanı",
                    style: TextStyle(color: onSurface, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Gün 3",
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Full Body Başlangıç • 45 Dk",
                style: TextStyle(color: onSurface.withAlpha(179), fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...exercises.map((ex) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildGlassCard(
            context: context,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.fitness_center, color: AppColors.primary),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ex["name"], 
                      style: TextStyle(color: onSurface, fontWeight: FontWeight.bold)
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showVideoDialog(context, ex["name"]),
                    icon: Icon(Icons.play_circle_fill, color: AppColors.primary.withOpacity(0.8)),
                    tooltip: "Hareket Videosunu İzle",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              subtitle: Text(
                "${ex["sets"]} Set x ${ex["reps"]}",
                style: TextStyle(color: onSurface.withAlpha(153)),
              ),
              trailing: SizedBox(
                width: 60,
                child: Text(
                  ex["weight"],
                  style: TextStyle(color: onSurface, fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        )),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Antrenman tamamlandı!"))
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Center(
            child: Text(
              "Antrenmanı Tamamla", 
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildProgramList(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final programs = [
      {"name": "5x5 Güç Programı", "level": "İleri Seviye", "days": "3 Gün/Hafta"},
      {"name": "Hipertrofi (Kas Yapımı)", "level": "Orta Seviye", "days": "4 Gün/Hafta"},
      {"name": "Yağ Yakımı & Kardiyo", "level": "Başlangıç", "days": "5 Gün/Hafta"},
      {"name": "Evde Antrenman", "level": "Tüm Seviyeler", "days": "3 Gün/Hafta"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: programs.length,
      itemBuilder: (ctx, index) {
        final prog = programs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildGlassCard(
            context: context,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${prog["name"]} detayları yakında!"),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(milliseconds: 800),
                )
              );
            },
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: onSurface.withAlpha(13), // 0.05
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.fitness_center, color: onSurface.withAlpha(77), size: 40), // 0.3
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prog["name"]!,
                        style: TextStyle(color: onSurface, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${prog["level"]} • ${prog["days"]}",
                        style: TextStyle(color: onSurface.withAlpha(153), fontSize: 13), // 0.6
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.primary),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPastWorkouts(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final pastWorkouts = [
      {"title": "Full Body - GÃ¼n 2", "date": "21.01.2026", "duration": "50 Dakika", "color": Colors.green},
      {"title": "Full Body - GÃ¼n 1", "date": "19.01.2026", "duration": "45 Dakika", "color": Colors.green},
      {"title": "Adaptasyon ProgramÄ±", "date": "15.01.2026", "duration": "30 Dakika", "color": onSurface.withAlpha(77)}, // 0.3
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: pastWorkouts.length,
      itemBuilder: (ctx, index) {
        final item = pastWorkouts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildGlassCard(
            context: context,
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${item["title"]} antrenman Ã¶zeti!"),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(milliseconds: 800),
                )
              );
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (item["color"] as Color).withAlpha(26), // 0.1
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline, color: item["color"] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"] as String,
                        style: TextStyle(color: onSurface, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item["date"]} â€¢ ${item["duration"]}",
                        style: TextStyle(color: onSurface.withAlpha(128), fontSize: 13), // 0.5
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: onSurface.withAlpha(77)), // 0.3
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVideoDialog(BuildContext context, String exerciseName) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1F2B).withAlpha(230) : Colors.white.withAlpha(230), // 0.9
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: onSurface.withAlpha(26)), // 0.1
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exerciseName,
                          style: TextStyle(color: onSurface, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: Icon(Icons.close, color: onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_outline, size: 48, color: AppColors.primary),
                          SizedBox(height: 8),
                          Text("Video YÃ¼kleniyor...", style: TextStyle(color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Bu alanda $exerciseName hareketinin yapÄ±lÄ±ÅŸ videosu oynatÄ±lacaktÄ±r.",
                    style: TextStyle(color: onSurface.withAlpha(153), fontSize: 13), // 0.6
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({required BuildContext context, required Widget child, VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(5), // 0.05 / 0.02
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white.withAlpha(26) : Colors.black.withAlpha(13), // 0.1 / 0.05
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

