import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/plant_data.dart';

class PlantVerificationScreen extends StatefulWidget {
  final PlantInfo plant;
  final String lang;

  const PlantVerificationScreen({
    super.key,
    required this.plant,
    required this.lang,
  });

  @override
  State<PlantVerificationScreen> createState() => _PlantVerificationScreenState();
}

class _PlantVerificationScreenState extends State<PlantVerificationScreen> {
  int likes = 0;
  int dislikes = 0;

  @override
  void initState() {
    super.initState();
    _loadVotes();
  }

  Future<void> _loadVotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      likes = prefs.getInt('${widget.plant.id}_likes') ?? 0;
      dislikes = prefs.getInt('${widget.plant.id}_dislikes') ?? 0;
    });
  }

  Future<void> _updateVotes({bool isLike = true}) async {
    final prefs = await SharedPreferences.getInstance();
    if (isLike) {
      likes += 1;
      await prefs.setInt('${widget.plant.id}_likes', likes);
    } else {
      dislikes += 1;
      await prefs.setInt('${widget.plant.id}_dislikes', dislikes);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;
    final lang = widget.lang;
    final name = lang == 'en' ? plant.nameEn : plant.nameLuhya;
    final description = lang == 'en' ? plant.descriptionEn : plant.descriptionLuhya;
    final preparation = lang == 'en' ? plant.preparationEn : plant.preparationLuhya;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify This Remedy'),
        backgroundColor: const Color(0xFF2D6A4F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Submitted by: Anonymous'),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 10),
            Text('Preparation: $preparation'),
            const SizedBox(height: 20),
            const Text('Verified by: Dr. Okoro', style: TextStyle(color: Colors.green)),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  onPressed: () => _updateVotes(isLike: true),
                ),
                Text('$likes'),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.thumb_down, color: Colors.red),
                  onPressed: () => _updateVotes(isLike: false),
                ),
                Text('$dislikes'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.flag, color: Colors.orange),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Flagged for review')),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
