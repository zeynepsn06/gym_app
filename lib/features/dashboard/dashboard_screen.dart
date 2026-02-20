import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import '../../core/services/user_service.dart';
import '../program/program_screen.dart';
import 'widgets/gym_occupancy_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final User? _currentUser = UserService().currentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar (Profile)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: onSurface.withAlpha(26),
                    child: Icon(Icons.person, color: onSurface), 
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Greeting Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hoş Geldin",
                  style: TextStyle(
                    color: onSurface.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      _currentUser?.name ?? "Sporcu",
                      style: TextStyle(
                        color: onSurface,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (_currentUser?.isTrainer == true || _currentUser?.isAdmin == true) ...[
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _currentUser?.isTrainer == true ? "TRAINER" : "ADMIN",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // Live Occupancy Status
            const GymOccupancyCard(),

            const SizedBox(height: 24),

            // Weekly Progress
            Text(
              "Haftalık Hedef",
              style: TextStyle(color: onSurface, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildGlassCard(
              context: context,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("3/5 Antrenman", style: TextStyle(color: onSurface, fontWeight: FontWeight.w600)),
                      Text("%60", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.6,
                      minHeight: 8,
                      backgroundColor: onSurface.withAlpha(13),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      final days = ["Pt", "Sa", "Ça", "Pe", "Cu", "Ct", "Pa"];
                      final isActive = [1, 3, 5].contains(index); 
                      return Column(
                        children: [
                          Text(
                            days[index], 
                            style: TextStyle(
                              color: onSurface.withAlpha(128), 
                              fontSize: 12
                            )
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive ? AppColors.primary : onSurface.withAlpha(26),
                              boxShadow: isActive ? [BoxShadow(color: AppColors.primary.withAlpha(128), blurRadius: 4)] : [],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Next Workout Card
            Text(
              "Sıradaki Antrenman",
              style: TextStyle(color: onSurface, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildGlassCard(
              context: context,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Body - Gün 3",
                              style: TextStyle(color: onSurface, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: onSurface.withAlpha(128)),
                                const SizedBox(width: 4),
                                Text(
                                  "Bugün • 18:00",
                                  style: TextStyle(color: onSurface.withOpacity(0.5), fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProgramScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(77),
                                blurRadius: 8,
                                offset: const Offset(0, 4)
                              )
                            ]
                          ),
                          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildTag(context, "6 Hareket", Icons.fitness_center),
                      const SizedBox(width: 12),
                      _buildTag(context, "45 Dakika", Icons.timer),
                      const SizedBox(width: 12),
                      _buildTag(context, "Orta", Icons.speed),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Stats Row
            Row(
              children: [
                _buildMiniStatCard(context, "Kalori", "1,240", Icons.local_fire_department_rounded, Colors.orange),
                const SizedBox(width: 16),
                _buildMiniStatCard(context, "Süre", "4h 20m", Icons.timer_rounded, Colors.blue),
              ],
            ),

            const SizedBox(height: 32), 
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Expanded(
      child: _buildGlassCard(
        context: context,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(color: onSurface, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  label,
                  style: TextStyle(color: onSurface.withAlpha(128), fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, IconData icon) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: onSurface.withAlpha(13),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: onSurface.withAlpha(26)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: onSurface.withAlpha(179)),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: onSurface, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required BuildContext context, required Widget child, EdgeInsets? padding}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white.withAlpha(26) : Colors.black.withAlpha(13),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

