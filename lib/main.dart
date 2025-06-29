import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:me/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'providers/user_profile_provider.dart';
import 'providers/lab_results_provider.dart';
import 'providers/prescription_provider.dart';
import 'providers/appointment_provider.dart';
import 'providers/conversation_provider.dart';
import 'providers/pharmacy_provider.dart';
import 'providers/video_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';
import 'providers/comment_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProfileProvider()),
        ChangeNotifierProvider.value(value: LabResultsProvider()),
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
            colorScheme: ColorScheme.light(
              primary: AppTheme.primary,
              secondary: AppTheme.accent,
              surface: Colors.white,
              background: AppTheme.lightGrey,
              error: AppTheme.error,
              onPrimary: AppTheme.white,
              onSecondary: AppTheme.white,
              onSurface: AppTheme.black,
              onBackground: AppTheme.black,
              onError: AppTheme.white,
            ),
            textTheme: GoogleFonts.interTextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: AppTheme.grey,
              type: BottomNavigationBarType.fixed,
              elevation: 8,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: AppTheme.primary,
            scaffoldBackgroundColor: AppTheme.darkBackground,
            colorScheme: ColorScheme.dark(
              primary: AppTheme.primary,
              secondary: AppTheme.accent,
              surface: AppTheme.darkSurface,
              background: AppTheme.darkBackground,
              error: AppTheme.error,
              onPrimary: AppTheme.white,
              onSecondary: AppTheme.white,
              onSurface: AppTheme.white,
              onBackground: AppTheme.white,
              onError: AppTheme.white,
              surfaceVariant: AppTheme.darkSurfaceVariant,
              onSurfaceVariant: AppTheme.darkGreyLight,
            ),
            textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            appBarTheme: AppBarTheme(
              backgroundColor: AppTheme.darkSurface,
              foregroundColor: AppTheme.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppTheme.darkSurface,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: AppTheme.darkGrey,
              type: BottomNavigationBarType.fixed,
              elevation: 8,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
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
                borderSide: BorderSide(color: AppTheme.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                borderSide: BorderSide(color: AppTheme.error),
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
              contentTextStyle: TextStyle(color: AppTheme.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              ),
            ),
          ),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const SignInScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/profile': (context) => UserProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/registration': (context) => const RegistrationScreen(),
            '/signin': (context) => const SignInScreen(),
            '/signup': (context) => const SignUpScreen(),
          },
        );
      },
    );
  }
}
