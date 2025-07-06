import 'package:flutter/material.dart';
import '../home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<bool> _confirmExit(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Exit Misala?'),
            content: const Text('Do you want to close the app?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('No')),
              TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Yes')),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _confirmExit(context),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3FFF3),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/medicinal_plant.png', height: 180),
                const SizedBox(height: 30),
                const Text('Welcome to Misala', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D6A4F))),
                const SizedBox(height: 12),
                const Text('Identify medicinal plants using AI, access remedies in English and Luhya, and help conserve indigenous knowledge.',
                    textAlign: TextAlign.center),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                  },
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
