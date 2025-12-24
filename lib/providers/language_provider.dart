import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static const String _languageKey = 'language_code';
  late SharedPreferences _prefs;
  String _languageCode = 'en'; // Default to English

  bool get isArabic => _languageCode == 'ar';
  String get languageCode => _languageCode;
  
  // Getters for MaterialApp configuration
  Locale get locale => Locale(_languageCode);
  TextDirection get textDirection => isArabic ? TextDirection.rtl : TextDirection.ltr;

  // Translation map
  final Map<String, Map<String, String>> _translations = {
    'en': {
      'home': 'Home',
      'chats': 'Chats',
      'videos': 'Videos',
      'pharmacy': 'Pharmacy',
      'profile': 'Profile',
      'settings': 'Settings',
      'logout': 'Logout',
      'login': 'Login',
      'signup': 'Sign Up',
      'welcome': 'Welcome',
      'search': 'Search',
      'notifications': 'Notifications',
      'messages': 'Messages',
      'appointments': 'Appointments',
      'doctors': 'Doctors',
      'patients': 'Patients',
      'prescriptions': 'Prescriptions',
      'lab_results': 'Lab Results',
      'health_records': 'Health Records',
    },
    'ar': {
      'home': 'الرئيسية',
      'chats': 'المحادثات',
      'videos': 'الفيديوهات',
      'pharmacy': 'الصيدلية',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'logout': 'تسجيل الخروج',
      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'welcome': 'مرحباً',
      'search': 'بحث',
      'notifications': 'الإشعارات',
      'messages': 'الرسائل',
      'appointments': 'المواعيد',
      'doctors': 'الأطباء',
      'patients': 'المرضى',
      'prescriptions': 'الوصفات الطبية',
      'lab_results': 'نتائج التحاليل',
      'health_records': 'السجلات الصحية',
    },
  };

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    _prefs = await SharedPreferences.getInstance();
    _languageCode = _prefs.getString(_languageKey) ?? 'en';
    notifyListeners();
  }

  String getText(String key) {
    return _translations[_languageCode]?[key] ?? key;
  }

  Future<void> setLanguage(String languageCode) async {
    if (languageCode == _languageCode) return;
    
    _languageCode = languageCode;
    await _prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLanguage = _languageCode == 'en' ? 'ar' : 'en';
    await setLanguage(newLanguage);
  }
}
