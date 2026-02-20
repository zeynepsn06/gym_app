
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import 'widgets/progress_chart.dart';

class BodyStatsScreen extends StatefulWidget {
  const BodyStatsScreen({super.key});

  @override
  State<BodyStatsScreen> createState() => _BodyStatsScreenState();
}

class _BodyStatsScreenState extends State<BodyStatsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fake data â€“ backend sonra baÄŸlanacak
    final double weight = 72.5;
    final double height = 180.0;
    final double bodyFat = 18.2;
    final double bmi = 22.8;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _header(context),
            ),
            
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13), // 0.05
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white10), // 0.1
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.white54, // 0.5
                tabs: const [
                  Tab(text: "İstatistikler"),
                  Tab(text: "Gelişim Analizi"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Ä°statistikler
                  _buildStatsTab(weight, height, bodyFat, bmi),
                  
                  // Tab 2: GeliÅŸim Analizi
                  _buildProgressTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsTab(double weight, double height, double bodyFat, double bmi) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _summaryCard(weight, height, bodyFat, bmi),
        const SizedBox(height: 28),

        _sectionTitle("Vücut Ölçüleri"),
        const SizedBox(height: 14),

        _measurementCard(
          title: "Üst Vücut",
          items: {
            "Omuz Genişliği": '48 cm',
            "Göğüs": '96 cm',
            "Kol (Biceps)": '34 cm',
          },
        ),

        const SizedBox(height: 16),

        _measurementCard(
          title: "Orta Bölge",
          items: {
            "Bel": '80 cm',
            "Karın": '82 cm',
          },
        ),

        const SizedBox(height: 16),

        _measurementCard(
          title: "Alt Vücut",
          items: {
            "Kalça": '94 cm',
            "Uyluk": '56 cm',
            "Baldır": '38 cm',
          },
        ),

        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildProgressTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const ProgressChart(),
        const SizedBox(height: 28),
        
        _sectionTitle("Aylık Kayıtlar"),
        const SizedBox(height: 20),

        _buildMonthlyGroup("Ocak 2024", [
           {"date": "31 Ocak", "value": "70.5 kg", "change": "-0.4 kg"},
           {"date": "24 Ocak", "value": "70.9 kg", "change": "-0.9 kg"},
           {"date": "17 Ocak", "value": "71.8 kg", "change": "+0.3 kg"},
        ]),

        const SizedBox(height: 16),

        _buildMonthlyGroup("Aralık 2023", [
           {"date": "28 Aralık", "value": "71.5 kg", "change": "-0.2 kg"},
           {"date": "21 Aralık", "value": "71.7 kg", "change": "+0.5 kg"},
        ]),
        
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildMonthlyGroup(String month, List<Map<String, String>> records) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            month,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...records.map((record) => _recentRecordItem(record["date"]!, record["value"]!, record["change"]!)),
      ],
    );
  }

  Widget _recentRecordItem(String date, String value, String change) {
    bool isNegative = change.contains('-');
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(13), // 0.05
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10), // 0.1
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white54, // 0.5
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Kilo Kaydı",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (isNegative ? Colors.green : Colors.red).withAlpha(26), // 0.1
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        change,
                        style: TextStyle(
                          color: isNegative ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // HEADER
  // =========================
  Widget _header(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Vücut İstatistikleri",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // =========================
  // SUMMARY CARD
  // =========================
  Widget _summaryCard(double weight, double height, double fat, double bmi) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13), // 0.05
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white10), // 0.1
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryItem("Boy", "${height.toInt()} cm"),
              _summaryItem("Kilo", "$weight kg"),
              _summaryItem("Yağ", "%$fat"),
              _summaryItem("VKE", bmi.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60, // 0.6
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // =========================
  // SECTION TITLE
  // =========================
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // =========================
  // MEASUREMENT CARD
  // =========================
  Widget _measurementCard({
    required String title,
    required Map<String, String> items,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13), // 0.05
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white10), // 0.1
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              ...items.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.key,
                        style: const TextStyle(
                          color: Colors.white70, // 0.7
                        ),
                      ),
                      Text(
                        e.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

