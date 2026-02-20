import 'dart:ui';
import 'package:flutter/material.dart';

class GymOccupancyCard extends StatelessWidget {
  const GymOccupancyCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    const int currentPeople = 78;
    const int maxCapacity = 150;
    const double occupancyRate = currentPeople / maxCapacity;
    
    
    const int maleCount = 48;
    const double maleRatio = maleCount / currentPeople;
    
    String statusText;
    Color statusColor;
    
    if (occupancyRate < 0.4) {
      statusText = "Sakin";
      statusColor = Colors.greenAccent;
    } else if (occupancyRate < 0.7) {
      statusText = "Normal";
      statusColor = Colors.orangeAccent;
    } else {
      statusText = "Çok Yoğun";
      statusColor = Colors.redAccent;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withAlpha(102),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withAlpha(26),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                    children: [
                      const Icon(Icons.people_alt_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Salon Doluluğu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withAlpha(77)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: statusColor.withAlpha(128), blurRadius: 4),
                            ]
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),

              // Main Stats
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$currentPeople",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "/ $maxCapacity Kapasite",
                      style: TextStyle(
                        color: Colors.white.withAlpha(128),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Density Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: occupancyRate,
                  minHeight: 8,
                  backgroundColor: Colors.white.withAlpha(26),
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ),

              const SizedBox(height: 24),
              
              // Gender Ratio
              Row(
                children: [
                  // Male
                  Expanded(
                    flex: (maleRatio * 100).toInt(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.male, color: Colors.blue, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "%${(maleRatio * 100).toInt()} Erkek",
                              style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Space
                  const SizedBox(width: 2),
                  // Female
                  Expanded(
                    flex: ((1 - maleRatio) * 100).toInt(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "%${((1 - maleRatio) * 100).toInt()} Kadın",
                              style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.female, color: Colors.pinkAccent, size: 16),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white.withAlpha(102), size: 14),
                  const SizedBox(width: 6),
                  Text(
                    "Veriler anlık QR girişleri ile güncellenir.",
                    style: TextStyle(color: Colors.white.withAlpha(102), fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
