const String defaultUserName = 'John Doe';
const String defaultUserSubtitle = 'Welcome back!';
const String defaultProfileImage = 'https://i.pravatar.cc/300';

// Add more constants as needed for dynamic values.

class AppConstants {
  // API Endpoints - Using mock API for development
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  // For production, change to: static const String baseUrl = 'https://api.yourbackend.com';

  // Asset Paths
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String themeCacheKey = 'theme_mode';
  static const String languageCacheKey = 'language_mode';

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String authError = 'Authentication failed. Please login again.';

  // Success Messages
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String appointmentBookedSuccess =
      'Appointment booked successfully';

  // Validation Messages
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordMismatch = 'Passwords do not match';

  // Language Support
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'ar'];

  // Arabic Translations
  static const Map<String, String> arabicTranslations = {
    // General
    'welcome': 'مرحباً',
    'welcome_back': 'مرحباً بعودتك',
    'loading': 'جاري التحميل...',
    'error': 'خطأ',
    'success': 'نجح',
    'cancel': 'إلغاء',
    'save': 'حفظ',
    'edit': 'تعديل',
    'delete': 'حذف',
    'confirm': 'تأكيد',
    'back': 'رجوع',
    'next': 'التالي',
    'previous': 'السابق',
    'close': 'إغلاق',
    'done': 'تم',
    'ok': 'حسناً',

    // Authentication
    'login': 'تسجيل الدخول',
    'signup': 'إنشاء حساب',
    'logout': 'تسجيل الخروج',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'confirm_password': 'تأكيد كلمة المرور',
    'forgot_password': 'نسيت كلمة المرور؟',
    'remember_me': 'تذكرني',
    'dont_have_account': 'ليس لديك حساب؟',
    'already_have_account': 'لديك حساب بالفعل؟',
    'invalid_credentials': 'بيانات غير صحيحة',

    // Navigation
    'home': 'الرئيسية',
    'appointments': 'المواعيد',
    'prescriptions': 'الوصفات الطبية',
    'lab_results': 'نتائج المختبر',
    'pharmacy': 'الصيدلية',
    'doctors': 'الأطباء',
    'profile': 'الملف الشخصي',
    'settings': 'الإعدادات',
    'search': 'البحث',
    'notifications': 'الإشعارات',

    // Appointments
    'book_appointment': 'حجز موعد',
    'upcoming_appointments': 'المواعيد القادمة',
    'past_appointments': 'المواعيد السابقة',
    'appointment_date': 'تاريخ الموعد',
    'appointment_time': 'وقت الموعد',
    'appointment_type': 'نوع الموعد',
    'appointment_status': 'حالة الموعد',
    'scheduled': 'مجدول',
    'completed': 'مكتمل',
    'cancelled': 'ملغي',
    'rescheduled': 'إعادة جدولة',
    'appointment_notes': 'ملاحظات الموعد',
    'appointment_location': 'موقع الموعد',

    // Prescriptions
    'medication_name': 'اسم الدواء',
    'dosage': 'الجرعة',
    'frequency': 'التكرار',
    'duration': 'المدة',
    'instructions': 'التعليمات',
    'refills': 'إعادة التعبئة',
    'active_prescriptions': 'الوصفات النشطة',
    'expired_prescriptions': 'الوصفات المنتهية',
    'prescription_date': 'تاريخ الوصفة',
    'expiry_date': 'تاريخ الانتهاء',

    // Lab Results
    'test_name': 'اسم الفحص',
    'test_date': 'تاريخ الفحص',
    'test_results': 'نتائج الفحص',
    'normal': 'طبيعي',
    'high': 'مرتفع',
    'low': 'منخفض',
    'critical': 'حرج',
    'reference_range': 'المدى المرجعي',
    'lab_name': 'اسم المختبر',

    // Pharmacy
    'nearby_pharmacies': 'الصيدليات القريبة',
    'pharmacy_name': 'اسم الصيدلية',
    'pharmacy_address': 'عنوان الصيدلية',
    'pharmacy_phone': 'هاتف الصيدلية',
    'opening_hours': 'ساعات العمل',
    'open_now': 'مفتوح الآن',
    'closed': 'مغلق',
    'delivery_available': 'التوصيل متاح',
    'drive_thru': 'خدمة السيارة',

    // Doctors
    'find_doctor': 'البحث عن طبيب',
    'doctor_name': 'اسم الطبيب',
    'specialty': 'التخصص',
    'experience': 'الخبرة',
    'rating': 'التقييم',
    'reviews': 'التقييمات',
    'consultation_fee': 'رسوم الاستشارة',
    'available_days': 'الأيام المتاحة',
    'book_consultation': 'حجز استشارة',

    // Profile
    'personal_info': 'المعلومات الشخصية',
    'medical_info': 'المعلومات الطبية',
    'emergency_contact': 'جهة اتصال الطوارئ',
    'blood_type': 'فصيلة الدم',
    'allergies': 'الحساسية',
    'medical_conditions': 'الحالات الطبية',
    'current_medications': 'الأدوية الحالية',
    'insurance_info': 'معلومات التأمين',

    // Settings
    'language': 'اللغة',
    'theme': 'المظهر',
    'dark_mode': 'الوضع المظلم',
    'light_mode': 'الوضع الفاتح',
    'notifications_settings': 'إعدادات الإشعارات',
    'privacy_settings': 'إعدادات الخصوصية',
    'about': 'حول التطبيق',
    'help': 'المساعدة',
    'contact_support': 'اتصل بالدعم',

    // Messages
    'no_data_available': 'لا توجد بيانات متاحة',
    'no_internet_connection': 'لا يوجد اتصال بالإنترنت',
    'try_again': 'حاول مرة أخرى',
    'data_loaded_successfully': 'تم تحميل البيانات بنجاح',
    'changes_saved': 'تم حفظ التغييرات',
    'operation_failed': 'فشلت العملية',
    'operation_successful': 'نجحت العملية',

    // Demo Info
    'demo_app_info': 'معلومات التطبيق التجريبي',
    'demo_app_description': 'هذا تطبيق طبي تجريبي مع بيانات وهمية للاختبار',
    'test_credentials': 'بيانات الاختبار',
    'test_email': 'البريد الإلكتروني: test@example.com',
    'test_password': 'كلمة المرور: password',
    'features_available': 'الميزات المتاحة',
    'mock_data_note': 'ملاحظة: هذه بيانات وهمية للاختبار فقط',
  };

  // English Translations (for reference)
  static const Map<String, String> englishTranslations = {
    'welcome': 'Welcome',
    'welcome_back': 'Welcome back',
    'loading': 'Loading...',
    'error': 'Error',
    'success': 'Success',
    'cancel': 'Cancel',
    'save': 'Save',
    'edit': 'Edit',
    'delete': 'Delete',
    'confirm': 'Confirm',
    'back': 'Back',
    'next': 'Next',
    'previous': 'Previous',
    'close': 'Close',
    'done': 'Done',
    'ok': 'OK',
  };

  // Get translation based on language
  static String getTranslation(String key, String language) {
    if (language == 'ar') {
      return arabicTranslations[key] ?? key;
    }
    return englishTranslations[key] ?? key;
  }
}
