import 'package:flutter/material.dart';

class SettingsService {
  // Singleton
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  // State
  final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.dark);
  final ValueNotifier<bool> notificationsEnabledNotifier = ValueNotifier(true);
  final ValueNotifier<bool> soundEnabledNotifier = ValueNotifier(false);

  // Getters
  bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;
  bool get notificationsEnabled => notificationsEnabledNotifier.value;
  bool get soundEnabled => soundEnabledNotifier.value;

  // Actions
  void toggleTheme(bool isDark) {
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleNotifications(bool enabled) {
    notificationsEnabledNotifier.value = enabled;
  }

  void toggleSound(bool enabled) {
    soundEnabledNotifier.value = enabled;
  }
}
