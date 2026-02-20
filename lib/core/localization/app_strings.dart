import 'package:flutter/material.dart';

class AppStrings {
  final Locale locale;

  AppStrings(this.locale);

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  static const supportedLocales = [
    Locale('tr'),
    Locale('en'),
  ];

  static const Map<String, Map<String, String>> _localizedValues = {
    // ================= TR =================
    'tr': {
      // ---- Login ----
      'loginTitle': 'Giriş Yap',
      'loginSubtitle': 'Hesabına giriş yap',
      'emailHint': 'E-posta',
      'passwordHint': 'Şifre',
      'forgotPassword': 'Şifremi unuttum',
      'loginButton': 'Giriş Yap',

      // ---- Login Validation ----
      'emailRequired': 'E-posta boş bırakılamaz',
      'emailInvalid': 'Geçerli bir e-posta adresi girin',
      'passwordRequired': 'Şifre boş bırakılamaz',
      'passwordShort': 'Şifre en az 6 karakter olmalıdır',

      // ---- Dashboard / Navbar ----
      'attendance': 'Katılım',
      'bodyStats': 'Vücut',
      'membership': 'Üyelik',
      'myQr': 'QR Kodum',
      'scanQr': 'QR Tara',

      // ---- Attendance Screen ----
      'attendanceTitle': 'Katılım',
      'thisWeek': 'Bu Hafta',
      'currentStreak': 'Mevcut Seri',
      'days': 'Gün',

      // ---- Weekdays ----
      'mon': 'Pts',
      'tue': 'Sal',
      'wed': 'Çar',
      'thu': 'Per',
      'fri': 'Cum',
      'sat': 'Cts',
      'sun': 'Paz',

      // ---- Body Stats Screen ----
      'bodyStatsTitle': 'Vücut İstatistikleri',
      'bodyMeasurements': 'Vücut Ölçüleri',
      'upperBody': 'Üst Vücut',
      'midSection': 'Orta Bölge',
      'lowerBody': 'Alt Vücut',

      'weight': 'Kilo',
      'bodyFat': 'Yağ Oranı',
      'bmi': 'VKİ',

      'shoulderWidth': 'Omuz Genişliği',
      'chest': 'Göğüs',
      'arm': 'Kol (Biceps)',
      'waist': 'Bel',
      'abdomen': 'Karın',
      'hip': 'Kalça',
      'thigh': 'Uyluk',
      'calf': 'Baldır',

      'add': 'Ekle',

      // ---- Membership Screen ----
      'monthlyMembership': 'Aylık Üyelik',
      'startDate': 'Başlangıç Tarihi',
      'endDate': 'Bitiş Tarihi',
      'remaining': 'Kalan',
      'status': 'Durum',
      'active': 'Aktif',
      'expired': 'Süresi Doldu',
      'membershipInfo':
          'Üyeliğiniz, kalan gün sayısı sıfıra ulaştığında otomatik olarak sona erecektir.',

      // ---- Hydration ----
'hydration': 'Su Takibi',
'dailyWaterGoal': 'Günlük Su Hedefi',
'ml': 'ml',




    },

    // ================= EN =================
    'en': {
      // ---- Login ----
      'loginTitle': 'Login',
      'loginSubtitle': 'Sign in to your account',
      'emailHint': 'Email',
      'passwordHint': 'Password',
      'forgotPassword': 'Forgot password',
      'loginButton': 'Login',

      // ---- Login Validation ----
      'emailRequired': 'Email cannot be empty',
      'emailInvalid': 'Enter a valid email address',
      'passwordRequired': 'Password cannot be empty',
      'passwordShort': 'Password must be at least 6 characters',

      // ---- Dashboard / Navbar ----
      'attendance': 'Attendance',
      'bodyStats': 'Body Stats',
      'membership': 'Membership',
      'myQr': 'My QR',
      'scanQr': 'Scan QR',

      // ---- Attendance Screen ----
      'attendanceTitle': 'Attendance',
      'thisWeek': 'This Week',
      'currentStreak': 'Current Streak',
      'days': 'Days',

      // ---- Weekdays ----
      'mon': 'Mon',
      'tue': 'Tue',
      'wed': 'Wed',
      'thu': 'Thu',
      'fri': 'Fri',
      'sat': 'Sat',
      'sun': 'Sun',

      // ---- Body Stats Screen ----
      'bodyStatsTitle': 'Body Stats',
      'bodyMeasurements': 'Body Measurements',
      'upperBody': 'Upper Body',
      'midSection': 'Mid Section',
      'lowerBody': 'Lower Body',

      'weight': 'Weight',
      'bodyFat': 'Body Fat',
      'bmi': 'BMI',

      'shoulderWidth': 'Shoulder Width',
      'chest': 'Chest',
      'arm': 'Arm (Biceps)',
      'waist': 'Waist',
      'abdomen': 'Abdomen',
      'hip': 'Hip',
      'thigh': 'Thigh',
      'calf': 'Calf',

      'add': 'Add',

      // ---- Membership Screen ----
      'monthlyMembership': 'Monthly Membership',
      'startDate': 'Start Date',
      'endDate': 'End Date',
      'remaining': 'Remaining',
      'status': 'Status',
      'active': 'Active',
      'expired': 'Expired',
      'membershipInfo':
          'Your membership will automatically expire when the remaining days reach zero.',


            // Hydration
          'hydration': 'Hydration',
'dailyWaterGoal': 'Daily Water Goal',
'ml': 'ml',


    },
  };

  String _get(String key) {
    final values =
        _localizedValues[locale.languageCode] ?? _localizedValues['en']!;
    return values[key] ?? key;
  }

  // ---------- Login ----------
  String get loginTitle => _get('loginTitle');
  String get loginSubtitle => _get('loginSubtitle');
  String get emailHint => _get('emailHint');
  String get passwordHint => _get('passwordHint');
  String get forgotPassword => _get('forgotPassword');
  String get loginButton => _get('loginButton');

  // ---------- Login Validation ----------
  String get emailRequired => _get('emailRequired');
  String get emailInvalid => _get('emailInvalid');
  String get passwordRequired => _get('passwordRequired');
  String get passwordShort => _get('passwordShort');

  // ---------- Common ----------
  String get attendance => _get('attendance');
  String get bodyStats => _get('bodyStats');
  String get membership => _get('membership');
  String get myQr => _get('myQr');
  String get scanQr => _get('scanQr');

  // ---------- Attendance ----------
  String get attendanceTitle => _get('attendanceTitle');
  String get thisWeek => _get('thisWeek');
  String get currentStreak => _get('currentStreak');
  String get days => _get('days');

  // ---------- Weekdays ----------
  String get mon => _get('mon');
  String get tue => _get('tue');
  String get wed => _get('wed');
  String get thu => _get('thu');
  String get fri => _get('fri');
  String get sat => _get('sat');
  String get sun => _get('sun');

  List<String> get weekDays => [mon, tue, wed, thu, fri, sat, sun];

  // ---------- Body Stats ----------
  String get bodyStatsTitle => _get('bodyStatsTitle');
  String get bodyMeasurements => _get('bodyMeasurements');
  String get upperBody => _get('upperBody');
  String get midSection => _get('midSection');
  String get lowerBody => _get('lowerBody');

  String get weight => _get('weight');
  String get bodyFat => _get('bodyFat');
  String get bmi => _get('bmi');

  String get shoulderWidth => _get('shoulderWidth');
  String get chest => _get('chest');
  String get arm => _get('arm');
  String get waist => _get('waist');
  String get abdomen => _get('abdomen');
  String get hip => _get('hip');
  String get thigh => _get('thigh');
  String get calf => _get('calf');

  String get add => _get('add');

  // ---------- Membership ----------
  String get monthlyMembership => _get('monthlyMembership');
  String get startDate => _get('startDate');
  String get endDate => _get('endDate');
  String get remaining => _get('remaining');
  String get status => _get('status');
  String get active => _get('active');
  String get expired => _get('expired');
  String get membershipInfo => _get('membershipInfo');


// Hydration 

String get hydration => _get('hydration');
String get dailyWaterGoal => _get('dailyWaterGoal');
String get ml => _get('ml');



}
