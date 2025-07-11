import 'package:flutter/material.dart';
import 'package:me/screens/pharmacy_screen.dart';
import '../screens/home_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/dm_list_screen.dart';
import '../screens/shorts_screen.dart';
import '../theme/app_theme.dart';

class ModernNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ModernNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 19,
      ),
      padding: const EdgeInsets.fromLTRB(
        5,
        10,
        5,
        5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? AppTheme.darkGradient
              : [
                  const Color(0xFFF8F9FA),
                  const Color(0xFFE9ECEF),
                ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: isDark
            ? AppTheme.darkShadow
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DMListScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShortsScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PharmacyScreen()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfileScreen()),
            );
          }
          onTap(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 30,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: isDark ? AppTheme.darkGrey : AppTheme.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: List.generate(5, (index) {
          final isSelected = currentIndex == index;
          return BottomNavigationBarItem(
            icon: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: isSelected
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primary.withOpacity(0.15),
                      )
                    : null,
                padding: const EdgeInsets.all(8),
                child: Icon(
                  [
                    Icons.home_outlined,
                    Icons.chat_bubble_rounded,
                    Icons.people_outline,
                    Icons.local_pharmacy_outlined,
                    Icons.person_outline,
                  ][index],
                  color: isSelected
                      ? AppTheme.primary
                      : isDark
                          ? AppTheme.darkGrey
                          : AppTheme.grey,
                ),
              ),
            ),
            label: ["Home", "Chat", "Social", "Pharmacy", "Profile"][index],
          );
        }),
      ),
    );
  }
}
