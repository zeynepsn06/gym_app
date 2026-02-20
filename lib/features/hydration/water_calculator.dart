class WaterCalculator {
  static int dailyWaterMl({
    required double weightKg,
  }) {
    return (weightKg * 35).round();
  }
}
