import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'providers/user_profile_provider.dart';
import 'providers/lab_results_provider.dart';
import 'providers/prescription_provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/conversation_provider.dart';
import 'providers/pharmacy_provider.dart';
import 'providers/video_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'providers/comment_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/api_service.dart';
import 'utils/secure_storage.dart';
import 'widgets/error_boundary.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized successfully!');

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
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Medical App',
          theme: ThemeData(
            primaryColor: AppTheme.primary,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primary,
              secondary: AppTheme.accent,
              surface: Colors.white,
              error: AppTheme.error,
              onPrimary: AppTheme.white,
              onSecondary: AppTheme.white,
              onSurface: AppTheme.black,
              onError: AppTheme.white,
            ),
            textTheme: GoogleFonts.interTextTheme(),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: AppTheme.grey,
              type: BottomNavigationBarType.fixed,
              elevation: 8,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: AppTheme.primary,
            scaffoldBackgroundColor: AppTheme.darkBackground,
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.primary,
              secondary: AppTheme.accent,
              surface: AppTheme.darkSurface,
              error: AppTheme.error,
              onPrimary: AppTheme.white,
              onSecondary: AppTheme.white,
              onSurface: AppTheme.white,
              onError: AppTheme.white,
              surfaceContainerHighest: AppTheme.darkSurfaceVariant,
              onSurfaceVariant: AppTheme.darkGreyLight,
            ),
            textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppTheme.darkSurface,
              foregroundColor: AppTheme.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppTheme.darkSurface,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: AppTheme.darkGrey,
              type: BottomNavigationBarType.fixed,
              elevation: 8,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
            cardTheme: ThemeData.dark().cardTheme.copyWith(
                  color: AppTheme.darkSurfaceVariant,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppTheme.darkSurfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                borderSide: const BorderSide(color: AppTheme.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                borderSide: const BorderSide(color: AppTheme.error),
              ),
            ),
            dialogTheme: ThemeData.dark().dialogTheme.copyWith(
                  backgroundColor: AppTheme.darkSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppTheme.borderRadiusLarge),
                  ),
                ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: AppTheme.darkSurfaceVariant,
              contentTextStyle: const TextStyle(color: AppTheme.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
            ),
          ),
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
          },
          builder: (context, child) => ErrorBoundary(child: child!),
        );
      },
    );
  }
}
