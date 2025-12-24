import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:me/screens/pharmacy_screen.dart';
import '../screens/home_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/dm_list_screen.dart';
import '../screens/shorts_screen.dart';
import '../theme/app_theme.dart';
import '../providers/language_provider.dart';

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
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          height: 100,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 19,
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
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  context,
                  0,
                  Icons.home_outlined,
                  Icons.home,
                  languageProvider.getText('home'),
                  languageProvider,
                ),
                _buildNavItem(
                  context,
                  1,
                  Icons.chat_outlined,
                  Icons.chat,
                  languageProvider.isArabic ? 'المحادثات' : 'Chats',
                  languageProvider,
                ),
                _buildNavItem(
                  context,
                  2,
                  Icons.play_circle_outlined,
                  Icons.play_circle,
                  languageProvider.isArabic ? 'الفيديوهات' : 'Videos',
                  languageProvider,
                ),
                _buildNavItem(
                  context,
                  3,
                  Icons.local_pharmacy_outlined,
                  Icons.local_pharmacy,
                  languageProvider.getText('pharmacy'),
                  languageProvider,
                ),
                _buildNavItem(
                  context,
                  4,
                  Icons.person_outline,
                  Icons.person,
                  languageProvider.getText('profile'),
                  languageProvider,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
    String label,
    LanguageProvider languageProvider,
  ) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? AppTheme.primary : Colors.grey[600],
              size: 22,
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: 50,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppTheme.primary : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
