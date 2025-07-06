import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _setLanguage(BuildContext context, String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose Your Language', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: () => _setLanguage(context, 'en'), child: const Text('English')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _setLanguage(context, 'luhya'), child: const Text('Luhya')),
          ],
        ),
      ),
    );
  }
}
