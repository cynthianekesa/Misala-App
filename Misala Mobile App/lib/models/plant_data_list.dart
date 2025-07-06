import '../models/plant_data.dart';

class PlantDataList {
  static List<PlantInfo> plantList = [
    PlantInfo(
      id: 'aloe_vera',
      nameEn: 'Aloe vera',
      nameLuhya: 'Rikaha',
      scientificName: 'Aloe barbadensis',
      descriptionEn: 'Used for burns, wounds, constipation, diabetes, and ulcers',
      descriptionLuhya: 'Inatumika kwa kuchoma, majeraha, constipation, kisukari, na vidonda',
      preparationEn: 'Fresh gel applied or juice extracted',
      preparationLuhya: 'Geli safi hutumiwa au juisi hutolewa',
      ailmentTreated: 'Burns, wounds, constipation, diabetes, ulcers',
      dosage: '1-2 tbsp gel/juice, 2-3 times daily',
    ),
    // Add all other plants from your CSV in the same format
    PlantInfo(
      id: 'pig_weed',
      nameEn: 'Pig Weed',
      nameLuhya: 'Tsimboka',
      scientificName: 'Amaranthus viridis',
      descriptionEn: 'Used for anemia, digestive issues, and fever',
      descriptionLuhya: 'Inatumika kwa upungufu wa damu, matatizo ya utumbo, na homa',
      preparationEn: 'Boiled leaves as tea or cooked as vegetable',
      preparationLuhya: 'Majani yaliyochemka kama chai au kupikwa kama mboga',
      ailmentTreated: 'Anemia, digestive issues, fever',
      dosage: '1 cup tea, 2-3 times daily',
    ),
    // Continue with all other plants...
  ];

  static PlantInfo getPlantById(String id) {
    return plantList.firstWhere((plant) => plant.id == id, orElse: () => PlantInfo(
      id: 'unknown',
      nameEn: 'Unknown Plant',
      nameLuhya: 'Mmea usiojulikana',
      scientificName: 'Unknown',
      descriptionEn: 'No information available',
      descriptionLuhya: 'Hakuna taarifa zinazopatikana',
      preparationEn: 'No preparation information',
      preparationLuhya: 'Hakuna maelezo ya maandalizi',
      ailmentTreated: 'Unknown',
      dosage: 'Unknown',
    ));
  }
}