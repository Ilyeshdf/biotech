import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            context,
            'Appearance',
            [
              _buildThemeToggle(context),
              _buildSettingTile(
                context,
                'Language',
                Icons.language,
                onTap: () {
                  // TODO: Implement language selection
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Account',
            [
              _buildSettingTile(
                context,
                'Edit Profile',
                Icons.person_outline,
                onTap: () {
                  // TODO: Navigate to edit profile
                },
              ),
              _buildSettingTile(
                context,
                'Privacy Settings',
                Icons.security,
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Notifications',
            [
              _buildSettingTile(
                context,
                'Push Notifications',
                Icons.notifications_outlined,
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              _buildSettingTile(
                context,
                'Terms of Service',
                Icons.description_outlined,
                onTap: () {
                  // TODO: Show terms of service
                },
              ),
              _buildSettingTile(
                context,
                'Privacy Policy',
                Icons.privacy_tip_outlined,
                onTap: () {
                  // TODO: Show privacy policy
                },
              ),
              _buildSettingTile(
                context,
                'App Version',
                Icons.info_outline,
                trailing: const Text('1.0.0'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    String title,
    IconData icon, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SwitchListTile(
          title: const Text('Dark Mode'),
          secondary: Icon(
            themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
        );
      },
    );
  }
}
