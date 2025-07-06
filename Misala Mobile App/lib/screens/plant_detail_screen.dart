import 'package:flutter/material.dart';
import '../models/plant_data.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantInfo plant;
  final String lang;

  const PlantDetailScreen({
    super.key,
    required this.plant,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    // Get the localized values based on language selection
    final commonName = lang == 'en' ? plant.nameEn : plant.nameLuhya;
    final description = lang == 'en' ? plant.descriptionEn : plant.descriptionLuhya;
    final preparation = lang == 'en' ? plant.preparationEn : plant.preparationLuhya;

    return Scaffold(
      appBar: AppBar(
        title: Text(commonName),
        backgroundColor: const Color(0xFF2D6A4F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scientific Name
            _buildDetailSection(
              title: lang == 'en' ? 'Scientific Name' : 'Jina la Kisayansi',
              content: plant.scientificName,
            ),
            const SizedBox(height: 20),
            
            // Local Name
            _buildDetailSection(
              title: lang == 'en' ? 'Local Name' : 'Jina la Kienyeji',
              content: plant.nameLuhya,
            ),
            const SizedBox(height: 20),
            
            // Ailments Treated
            _buildDetailSection(
              title: lang == 'en' ? 'Ailments Treated' : 'Matatizo Yanayotibwa',
              content: plant.ailmentTreated,
            ),
            const SizedBox(height: 20),
            
            // Preparation Method
            _buildDetailSection(
              title: lang == 'en' ? 'Preparation Method' : 'Njia ya Kutayarisha',
              content: preparation,
            ),
            const SizedBox(height: 20),
            
            // Dosage
            _buildDetailSection(
              title: lang == 'en' ? 'Dosage' : 'Kipimo',
              content: plant.dosage,
            ),
            const SizedBox(height: 20),
            
            // Description
            _buildDetailSection(
              title: lang == 'en' ? 'Description' : 'Maelezo',
              content: description,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D6A4F),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}