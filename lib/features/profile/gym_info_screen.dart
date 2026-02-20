
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import 'package:gym_app/core/widgets/premium_background.dart';

class GymInfoScreen extends StatefulWidget {
  const GymInfoScreen({super.key});

  @override
  State<GymInfoScreen> createState() => _GymInfoScreenState();
}

class _GymInfoScreenState extends State<GymInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Salon Hakkında",
            style: TextStyle(color: onSurface, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            // Custom Modern Tab Bar
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: onSurface.withAlpha(26)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(77),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                labelColor: Colors.white,
                unselectedLabelColor: onSurface.withAlpha(153),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.all(4),
                splashBorderRadius: BorderRadius.circular(25),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.hovered)) {
                      return onSurface.withAlpha(13); // Subtle hover effect
                    }
                    if (states.contains(WidgetState.pressed)) {
                      return AppColors.primary.withAlpha(26); // Subtle press effect
                    }
                    return null;
                  },
                ),
                tabs: const [
                  Tab(text: "Genel"),
                  Tab(text: "Saatler"),
                  Tab(text: "Eğitmen"),
                  Tab(text: "İletişim"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGeneralInfo(context),
                  _buildHours(context),
                  _buildTrainers(context),
                  _buildContact(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13), // 0.05
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(26)), // 0.1
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildGeneralInfo(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildGlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Salonumuz HakkÄ±nda",
                style: TextStyle(color: onSurface, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "En son teknoloji ekipmanlarÄ±mÄ±z ve uzman kadromuzla hedeflerinize ulaÅŸmanÄ±z iÃ§in buradayÄ±z. 2000 mÂ² geniÅŸliÄŸinde ferah antrenman alanÄ±mÄ±z, Ã¶zel grup ders stÃ¼dyolarÄ±mÄ±z ve spa alanÄ±mÄ±z ile hizmetinizdeyiz.",
                style: TextStyle(color: onSurface.withAlpha(179), fontSize: 14, height: 1.5), // 0.7
              ),
              const SizedBox(height: 20),
              _buildFeatureItem(context, Icons.check_circle, "Son Teknoloji Ekipmanlar"),
              _buildFeatureItem(context, Icons.check_circle, "Uzman EÄŸitmen Kadrosu"),
              _buildFeatureItem(context, Icons.check_circle, "GeniÅŸ Pilates & Yoga StÃ¼dyosu"),
              _buildFeatureItem(context, Icons.check_circle, "Sauna & Buhar OdasÄ±"),
              _buildFeatureItem(context, Icons.check_circle, "Vitamin Bar & Lounge AlanÄ±"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: onSurface.withAlpha(204), fontSize: 14)), // 0.8
        ],
      ),
    );
  }

  Widget _buildHours(BuildContext context) {
    final now = DateTime.now();
    final today = now.weekday; // 1 = Mon, 7 = Sun

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildGlassContainer(
          child: Column(
            children: [
              _buildHourRow(context, "Pazartesi", "06:00 - 23:00", isToday: today == 1),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "SalÄ±", "06:00 - 23:00", isToday: today == 2),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "Ã‡arÅŸamba", "06:00 - 23:00", isToday: today == 3),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "PerÅŸembe", "06:00 - 23:00", isToday: today == 4),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "Cuma", "06:00 - 23:00", isToday: today == 5),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "Cumartesi", "09:00 - 22:00", isToday: today == 6),
              const Divider(color: Colors.white10),
              _buildHourRow(context, "Pazar", "10:00 - 20:00", isToday: today == 7),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildGlassContainer(
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Resmi tatillerde Ã§alÄ±ÅŸma saatlerimiz deÄŸiÅŸiklik gÃ¶sterebilir. LÃ¼tfen duyurularÄ± takip ediniz.",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHourRow(BuildContext context, String day, String time, {bool isToday = false}) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                day,
                style: TextStyle(
                  color: isToday ? AppColors.primary : onSurface,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              if (isToday)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(51),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text("BugÃ¼n", style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          Text(
            time,
            style: TextStyle(
              color: isToday ? AppColors.primary : onSurface.withAlpha(179),
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainers(BuildContext context) {
     final trainers = [
      {"name": "Burak YÄ±lmaz", "role": "Head Coach", "specialty": "VÃ¼cut GeliÅŸtirme", "image": ""},
      {"name": "AyÅŸe Demir", "role": "Personal Trainer", "specialty": "Pilates & Yoga", "image": ""},
      {"name": "Mehmet Kaya", "role": "Fitness EÄŸitmeni", "specialty": "Fonksiyonel Antrenman", "image": ""},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: trainers.length,
      itemBuilder: (context, index) {
        final trainer = trainers[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildGlassContainer(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Text(trainer["name"]!.substring(0, 1), style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainer["name"]!,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${trainer["role"]} â€¢ ${trainer["specialty"]}",
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.info_outline, color: Colors.white54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContact(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildGlassContainer(
          child: Column(
            children: [
              _buildContactItem(context, Icons.location_on, "Adres", "AtatÃ¼rk Mah. Cumhuriyet Cad. No: 123, KadÄ±kÃ¶y/Ä°stanbul"),
              const SizedBox(height: 20),
              _buildContactItem(context, Icons.phone, "Telefon", "+90 (216) 123 45 67"),
              const SizedBox(height: 20),
              _buildContactItem(context, Icons.email, "E-posta", "info@gym.com"),
              const SizedBox(height: 20),
              _buildContactItem(context, Icons.language, "Web Sitesi", "www.gym.com"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Placeholder for Map
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 48, color: onSurface.withAlpha(128)),
                const SizedBox(height: 12),
                Text("Harita GÃ¶rÃ¼nÃ¼mÃ¼", style: TextStyle(color: onSurface.withAlpha(128))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String title, String content) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: onSurface.withAlpha(128), fontSize: 12)),
              const SizedBox(height: 4),
              Text(content, style: TextStyle(color: onSurface, fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

