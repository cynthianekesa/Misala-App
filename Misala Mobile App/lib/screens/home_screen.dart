import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/image_input.dart';
import '../models/plant_data.dart';
import '../models/plant_data_list.dart';  // Added this import
import '../models/scan_history.dart';
import '../helpers/database_helper.dart';
import 'plant_detail_screen.dart';
import 'scan_history_screen.dart';
import 'chatbot_screen.dart';
import 'community_wisdom_screen.dart';
import 'community_submission_screen.dart';
import 'conversation_hub_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  String _prediction = '';
  PlantInfo? _predictedPlant;
  String _selectedLang = 'en';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _wakeServer();
  }

  void _wakeServer() async {
    try {
      await http.get(Uri.parse('https://image-prediction-uzi7.onrender.com/'));
    } catch (e) {
      // Ignore wake errors
    }
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLang = prefs.getString('language') ?? 'en';
    });
  }

  void _handleImagePicked(File image) async {
    setState(() {
      _selectedImage = image;
      _prediction = 'Analyzing image... please wait ⏳';
      _predictedPlant = null;
    });

    final uri = Uri.parse('https://image-prediction-uzi7.onrender.com/predict');
    try {
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final decoded = json.decode(body);
        final label = decoded['class'];
        final confidence = decoded['confidence'];

        if (label == null) {
          setState(() {
            _prediction = 'No prediction returned.';
          });
          return;
        }

        // Updated plant matching using PlantDataList
        final matchedPlant = PlantDataList.plantList.firstWhere(
          (plant) => plant.nameEn.toLowerCase() == label.toLowerCase(),
          orElse: () => PlantInfo(
            id: 'unknown',
            nameEn: label,
            nameLuhya: label,
            scientificName: 'Unknown',
            descriptionEn: 'No description available.',
            descriptionLuhya: 'Tsibala chibwabwa.',
            preparationEn: 'No preparation info available.',
            preparationLuhya: 'Tsibala tsilukhu.',
            ailmentTreated: 'Unknown',
            dosage: 'Unknown',
          ),
        );

        setState(() {
          _predictedPlant = matchedPlant;
          _prediction = _selectedLang == 'en'
              ? matchedPlant.nameEn
              : matchedPlant.nameLuhya;
        });

        final now = DateFormat('yyyy-MM-dd • HH:mm').format(DateTime.now());
        await DatabaseHelper.instance.insertScan(
          ScanHistory(
            plantName: _prediction,
            language: _selectedLang,
            date: now,
          ),
        );
      } else {
        final errorBody = await response.stream.bytesToString();
        setState(() {
          _prediction = 'Prediction failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _prediction = 'Something went wrong. Try again later.';
      });
    }
  }

  void _handleSubmit() {
    if (_predictedPlant == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlantDetailScreen(
          plant: _predictedPlant!,
          lang: _selectedLang,
        ),
      ),
    );
  }

  void _changeLanguage(String? lang) {
    if (lang == null) return;
    setState(() {
      _selectedLang = lang;
      if (_predictedPlant != null) {
        _prediction = lang == 'en'
            ? _predictedPlant!.nameEn
            : _predictedPlant!.nameLuhya;
      }
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('language', lang);
    });
  }

  final List<Widget> _screens = [
    const _PlantIdentificationTab(),
    const CommunityWisdomScreen(),
    const ConversationHubScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FFF3),
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Identify a Plant'
              : _currentIndex == 1
                  ? 'Community Wisdom'
                  : 'Conversation Hub',
        ),
        backgroundColor: const Color(0xFF2D6A4F),
        actions: [
          if (_currentIndex == 0) ...[
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScanHistoryScreen()),
                );
              },
            ),
          ],
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatbotScreen()),
              );
            },
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLang,
              icon: const Icon(Icons.language, color: Colors.white),
              dropdownColor: Colors.white,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'luhya', child: Text('Luhya')),
              ],
              onChanged: _changeLanguage,
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CommunitySubmissionScreen(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF2D6A4F),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF2D6A4F),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Identify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Conversations',
          ),
        ],
      ),
    );
  }
}

class _PlantIdentificationTab extends StatelessWidget {
  const _PlantIdentificationTab();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeScreenState>()!;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ImageInput(state._handleImagePicked),
          const SizedBox(height: 20),
          if (state._selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(state._selectedImage!, height: 200),
            ),
          const SizedBox(height: 20),
          if (state._prediction.isNotEmpty)
            Text(
              'Prediction: ${state._prediction}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B4332),
              ),
            ),
          const Spacer(),
          if (state._predictedPlant != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state._handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E44AD),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('View Details', style: TextStyle(fontSize: 18)),
              ),
            ),
        ],
      ),
    );
  }
}