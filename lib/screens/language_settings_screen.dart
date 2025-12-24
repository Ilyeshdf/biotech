import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
      ),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('English'),
                trailing: languageProvider.languageCode == 'en'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => languageProvider.setLanguage('en'),
              ),
              ListTile(
                title: const Text('العربية (Arabic)'),
                trailing: languageProvider.languageCode == 'ar'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => languageProvider.setLanguage('ar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
