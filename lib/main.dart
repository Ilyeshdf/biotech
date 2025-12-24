import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:me/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/add_appointment_screen.dart';
import 'screens/add_prescription_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/find_doctor.dart';
import 'screens/lab_results_screen.dart';
import 'screens/prescription_screen.dart';
import 'screens/buildSpecialityIcon.dart';
import 'screens/dm_list_screen.dart';
import 'screens/pharmacy_screen.dart';
import 'screens/shorts_screen.dart';
import 'screens/search_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/email_verification_screen.dart';
import 'screens/language_settings_screen.dart';
import 'providers/user_profile_provider.dart';
import 'providers/lab_results_provider.dart';
import 'providers/prescription_provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/conversation_provider.dart';
import 'providers/pharmacy_provider.dart';
import 'providers/video_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'theme/app_theme.dart';
import 'providers/comment_provider.dart';
import 'services/api_service.dart';
import 'utils/secure_storage.dart';

import 'widgets/error_boundary.dart';
import 'screens/doctor_sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize API Service
  ApiService().initialize();
  print('API Service initialized successfully!');

  // Check secure storage availability
  final secureStorage = SecureStorage();
  final isSecureStorageAvailable =
      await secureStorage.isSecureStorageAvailable();
  print('Secure storage available: $isSecureStorageAvailable');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => LabResultsProvider()),
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ConversationProvider()),
        ChangeNotifierProvider(create: (_) => PharmacyProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final secureStorage = SecureStorage();
    final token = await secureStorage.getToken();
    if (mounted) {
      setState(() {
        _isAuthenticated = token != null && token.isNotEmpty;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isAuthenticated) {
      return const HomeScreen();
    } else {
      return const SignInScreen();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return MaterialApp(
          title: 'Medical App',
          locale: languageProvider.locale,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'SA'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const AuthGate(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/profile': (context) => const UserProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/registration': (context) => const RegistrationScreen(),
            '/signin': (context) => const SignInScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/doctor_signup': (context) => const DoctorSignUpScreen(),
            '/add_appointment': (context) => const AddAppointmentScreen(),
            '/add_prescription': (context) => const AddPrescriptionScreen(),
            '/appointments': (context) => const AppointmentsScreen(),
            '/find_doctor': (context) => const FindDoctor(),
            '/lab_results': (context) => const LabResultsScreen(),
            '/prescription': (context) => const PrescriptionScreen(),
            '/speciality_icon': (context) =>
                const DoctorListPage(specialty: 'Cardiac'),
            '/dm_list': (context) => const DMListScreen(),
            '/pharmacy': (context) => const PharmacyScreen(),
            '/shorts': (context) => const ShortsScreen(),
            '/search': (context) => const SearchScreen(),
            '/notifications': (context) => const NotificationsScreen(),
            '/email_verification': (context) => const EmailVerificationScreen(),
            '/language_settings': (context) => const LanguageSettingsScreen(),
          },
          builder: (context, child) => Directionality(
            textDirection: languageProvider.textDirection,
            child: ErrorBoundary(child: child!),
          ),
        );
      },
    );
  }
}
