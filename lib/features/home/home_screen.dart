import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import '../dashboard/dashboard_screen.dart';
import '../program/program_screen.dart';
import '../qr/qr_screen.dart';
import '../diet/diet_screen.dart';
import '../body_stats/body_stats_screen.dart';
import '../profile/profile_screen.dart';
import 'package:gym_app/core/widgets/premium_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProgramScreen(key: ValueKey('program_screen_v2')),
    const DietScreen(),
    const BodyStatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    



    return PremiumBackground(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          height: 72,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B).withAlpha(240) : Colors.white.withAlpha(242),
            borderRadius: BorderRadius.circular(50), 
            border: Border.all(
              color: isDark ? Colors.white.withAlpha(26) : Colors.black.withAlpha(13), 
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50), 
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(context, 0, Icons.grid_view_rounded, 'Ana Sayfa'),
                    _buildNavItem(context, 1, Icons.fitness_center_rounded, 'Antrenman'),
                    _buildNavItem(context, 2, Icons.restaurant_menu_rounded, 'Diyet'),
                    _buildNavItem(context, 3, Icons.bar_chart_rounded, 'Vücut'),
                    _buildNavItem(context, 4, Icons.person_rounded, 'Profil'),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrScreen()),
            );
          },
          elevation: 8,
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(CupertinoIcons.qrcode_viewfinder, color: Colors.white, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12, 
          vertical: 12
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isDark ? Colors.white.withAlpha(26) : Colors.black.withAlpha(13)) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected 
              ? AppColors.primary 
              : (isDark ? Colors.white.withAlpha(128) : Colors.black.withAlpha(128)),
        ),
      ),
    );
  }
}
