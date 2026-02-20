import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import '../../core/services/settings_service.dart';
import '../../core/services/user_service.dart';

import 'package:gym_app/core/widgets/premium_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _notificationsEnabled;
  late bool _darkMode;
  late bool _soundEnabled;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final settings = SettingsService();
    _notificationsEnabled = settings.notificationsEnabled;
    _darkMode = settings.isDarkMode;
    _soundEnabled = settings.soundEnabled;
  }
  
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Ayarlar", style: TextStyle(color: onSurface, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              const SizedBox(height: 10),
              _buildSectionHeader("Genel Yapılandırma"),
              const SizedBox(height: 12),
              _buildGlassContainer(
                 child: Column(
                   children: [
                     _buildSwitchTile(
                       "Bildirimler", 
                       "Antrenman ve sistem hatırlatıcıları", 
                       Icons.notifications_active_outlined,
                       _notificationsEnabled, 
                       (val) {
                         setState(() => _notificationsEnabled = val);
                         SettingsService().toggleNotifications(val);
                       }
                     ),
                     _buildDivider(),
                     _buildSwitchTile(
                       "Ses Efektleri", 
                       "Egzersiz sırasındaki bildirim sesleri", 
                       Icons.volume_up_outlined,
                       _soundEnabled, 
                       (val) {
                         setState(() => _soundEnabled = val);
                         SettingsService().toggleSound(val);
                       }
                     ),
                     _buildDivider(),
                     _buildSwitchTile(
                       "Karanlık Mod", 
                       "Göz yorgunluğunu azaltan koyu tema", 
                       Icons.dark_mode_outlined,
                       _darkMode, 
                       (val) {
                          setState(() => _darkMode = val);
                          SettingsService().toggleTheme(val);
                       }
                     ),
                   ],
                 )
              ),
    
              const SizedBox(height: 32),
              _buildSectionHeader("Hesap ve Güvenlik"),
              const SizedBox(height: 12),
              _buildGlassContainer(
                child: Column(
                  children: [
                     _buildActionTile("Profil Düzenle", Icons.person_outline, _showEditProfileDialog),
                     _buildDivider(),
                     _buildActionTile("Åifre DeÄŸiÅŸtir", Icons.lock_outline, _showChangePasswordDialog),
                     _buildDivider(),
                     _buildActionTile("Gizlilik Politikası", Icons.privacy_tip_outlined, _showPrivacyPolicy),
                     _buildDivider(),
                     _buildActionTile("Yardım Merkezi", Icons.help_outline_rounded, _showHelpCenter),
                  ],
                )
              ),
              
              const SizedBox(height: 40),
              _buildLogoutButton(),
              
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "Versiyon 1.0.2",
                  style: TextStyle(color: onSurface.withAlpha(77), fontSize: 12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- Account & Security Dialogs ---

  void _showEditProfileDialog() {
    final user = UserService().currentUser;
    final nameController = TextEditingController(text: user?.name);
    final emailController = TextEditingController(text: user?.email);

    _showStyledDialog(
      title: "Profili Düzenle",
      icon: Icons.person_rounded,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogField("Ad Soyad", nameController, Icons.person_outline),
          const SizedBox(height: 16),
          _buildDialogField("E-posta", emailController, Icons.email_outlined),
        ],
      ),
      onConfirm: () {
        UserService().updateProfile(
          name: nameController.text,
          email: emailController.text,
        );
        Navigator.pop(context);
        _showSuccessBadge("Profil güncellendi");
      },
      confirmText: "Güncelle",
    );
  }

  void _showChangePasswordDialog() {
    final currentPass = TextEditingController();
    final newPass = TextEditingController();

    _showStyledDialog(
      title: "Åifre DeÄŸiÅŸtir",
      icon: Icons.lock_reset_rounded,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogField("Mevcut Åifre", currentPass, Icons.lock_outline, obscure: true),
          const SizedBox(height: 16),
          _buildDialogField("Yeni Åifre", newPass, Icons.lock_outline, obscure: true),
        ],
      ),
      onConfirm: () {
        Navigator.pop(context);
        _showSuccessBadge("Åifreniz baÅŸarÄ±yla deÄŸiÅŸtirildi");
      },
      confirmText: "DeÄŸiÅŸtir",
    );
  }

  void _showPrivacyPolicy() {
    _showStyledDialog(
      title: "Gizlilik Politikası",
      icon: Icons.policy_rounded,
      content: Container(
        constraints: const BoxConstraints(maxHeight: 200),
        child: SingleChildScrollView(
          child: Text(
            "GymApp olarak gizliliğinize önem veriyoruz. Verileriniz sadece antrenman performansınızı takip etmek ve size daha iyi hizmet sunmak amacıyla kullanılmaktadır. Üçüncü şahılar ile asla paylaşılmaz.\n\n"
            "Veri Toplama: Ad soyad, e-posta, fiziksel gelişim verileri.\n"
            "Kullanım Amacı: Kişiselleştirilmiş programlar hazırlamak.\n"
            "Haklarınız: Verilerinizi sildirme ve güncelleme hakkına sahipsiniz.",
            style: TextStyle(color: Colors.white.withAlpha(179), fontSize: 14, height: 1.5),
          ),
        ),
      ),
      onConfirm: () => Navigator.pop(context),
      confirmText: "Kapat",
    );
  }

  void _showHelpCenter() {
    _showStyledDialog(
      title: "Yardım Merkezi",
      icon: Icons.help_outline_rounded,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHelpItem(Icons.support_agent_rounded, "Canlı Destek", "Hergün 09:00 - 18:30"),
          const SizedBox(height: 12),
          _buildHelpItem(Icons.alternate_email_rounded, "E-posta Gönder", "destek@gymapp.com"),
          const SizedBox(height: 12),
          _buildHelpItem(Icons.description_outlined, "Sıkça Sorulan Sorular", "Bilgi bankasını oku"),
        ],
      ),
      onConfirm: () => Navigator.pop(context),
      confirmText: "Kapat",
    );
  }

  // --- UI Components & Helpers ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withAlpha(26)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 13)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withAlpha(77);
          }
          return Colors.white.withAlpha(51);
        }),
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          shape: BoxShape.circle
        ),
        child: const Icon(Icons.chevron_right_rounded, color: Colors.white30, size: 18),
      ),
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller, IconData icon, {bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withAlpha(26)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withAlpha(77), fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildHelpItem(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(sub, style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  void _showStyledDialog({
    required String title,
    required IconData icon,
    required Widget content,
    required VoidCallback onConfirm,
    required String confirmText,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withAlpha(230),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withAlpha(26)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: AppColors.primary, size: 40),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  content,
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      if (confirmText != "Kapat")
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Ä°ptal", style: TextStyle(color: Colors.white.withAlpha(153))),
                          ),
                        ),
                      if (confirmText != "Kapat") const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(confirmText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessBadge(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _showLogoutConfirmation,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.redAccent.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent.withAlpha(51)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout_rounded, color: Colors.redAccent),
                  SizedBox(width: 12),
                  Text(
                    "Ã‡Ä±kÄ±ÅŸ Yap",
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2B).withAlpha(242),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withAlpha(26)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 48),
                  const SizedBox(height: 20),
                  const Text(
                    "Ã‡Ä±kÄ±ÅŸ Yap?",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "HesabÄ±nÄ±zdan Ã§Ä±kÄ±ÅŸ yapmak istediÄŸinize emin misiniz?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Ä°ptal", style: TextStyle(color: Colors.white.withAlpha(153))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text("Ã‡Ä±kÄ±ÅŸ Yap", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.white.withAlpha(13), indent: 70, endIndent: 20);
  }
}

