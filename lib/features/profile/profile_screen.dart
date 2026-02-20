
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import '../../core/services/user_service.dart';
import '../attendance/attendance_screen.dart';
import 'notes_screen.dart';
import '../membership/membership_screen.dart';
import '../settings/settings_screen.dart';
import 'gym_info_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserService().currentUser;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.name ?? "Kullanıcı",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(51), // 0.2
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary.withAlpha(128)), // 0.5
                      ),
                      child: Text(
                        user?.isTrainer == true ? "Eğitmen" : "Premium Üye",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Daha Fazla",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Menu Options
              _buildMenuOption(
                context,
                icon: Icons.history_rounded,
                title: "Salon Girişleri",
                subtitle: "Salon giriş çıkış kayıtları",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen())),
              ),
              const SizedBox(height: 16),
              _buildMenuOption(
                context,
                icon: Icons.note_alt_rounded,
                title: "Notlarım",
                subtitle: "Kayıtlı notlar ve günlükler",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesScreen())),
              ),
              const SizedBox(height: 16),
              _buildMenuOption(
                context,
                icon: Icons.card_membership_rounded,
                title: "Üyelik Durumu",
                subtitle: "Paket detayları ve kalan süre",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipScreen())),
              ),
              const SizedBox(height: 16),
              _buildMenuOption(
                context,
                icon: Icons.business_rounded,
                title: "Salonumuz",
                subtitle: "Saatler, konum ve eğitmenler",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GymInfoScreen())),
              ),
              const SizedBox(height: 16),
              _buildMenuOption(
                context,
                icon: Icons.settings_rounded,
                title: "Ayarlar",
                subtitle: "Uygulama ve hesap ayarları",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
              ),
             
              const SizedBox(height: 100), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13), // 0.05
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10), // 0.1
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(26), // 0.1
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white54, // 0.5
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.white54), // 0.5
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

