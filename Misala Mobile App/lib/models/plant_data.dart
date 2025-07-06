class PlantInfo {
  final String id;
  final String nameEn;
  final String nameLuhya;
  final String scientificName;
  final String descriptionEn;
  final String descriptionLuhya;
  final String preparationEn;
  final String preparationLuhya;
  final String ailmentTreated;
  final String dosage;

  PlantInfo({
    required this.id,
    required this.nameEn,
    required this.nameLuhya,
    required this.scientificName,
    required this.descriptionEn,
    required this.descriptionLuhya,
    required this.preparationEn,
    required this.preparationLuhya,
    required this.ailmentTreated,
    required this.dosage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameLuhya': nameLuhya,
      'scientificName': scientificName,
      'descriptionEn': descriptionEn,
      'descriptionLuhya': descriptionLuhya,
      'preparationEn': preparationEn,
      'preparationLuhya': preparationLuhya,
      'ailmentTreated': ailmentTreated,
      'dosage': dosage,
    };
  }

  factory PlantInfo.fromMap(Map<String, dynamic> map) {
    return PlantInfo(
      id: map['id'],
      nameEn: map['nameEn'],
      nameLuhya: map['nameLuhya'],
      scientificName: map['scientificName'],
      descriptionEn: map['descriptionEn'],
      descriptionLuhya: map['descriptionLuhya'],
      preparationEn: map['preparationEn'],
      preparationLuhya: map['preparationLuhya'],
      ailmentTreated: map['ailmentTreated'],
      dosage: map['dosage'],
    );
  }
}