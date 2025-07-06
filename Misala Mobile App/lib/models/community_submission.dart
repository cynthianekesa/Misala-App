class CommunitySubmission {
  final int? id;
  final String englishName;
  final String scientificName;
  final String localName;
  final String ailmentTreated;
  final String preparationMethod;
  final bool isVerified;
  final String submittedBy;
  final DateTime submissionDate;

  CommunitySubmission({
    this.id,
    required this.englishName,
    required this.scientificName,
    required this.localName,
    required this.ailmentTreated,
    required this.preparationMethod,
    required this.isVerified,
    required this.submittedBy,
    required this.submissionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'englishName': englishName,
      'scientificName': scientificName,
      'localName': localName,
      'ailmentTreated': ailmentTreated,
      'preparationMethod': preparationMethod,
      'isVerified': isVerified ? 1 : 0, // Convert bool to int
      'submittedBy': submittedBy,
      'submissionDate': submissionDate.toIso8601String(),
    };
  }

  factory CommunitySubmission.fromMap(Map<String, dynamic> map) {
    return CommunitySubmission(
      id: map['id'],
      englishName: map['englishName'],
      scientificName: map['scientificName'],
      localName: map['localName'],
      ailmentTreated: map['ailmentTreated'],
      preparationMethod: map['preparationMethod'],
      isVerified: map['isVerified'] == 1, // Convert int to bool
      submittedBy: map['submittedBy'],
      submissionDate: DateTime.parse(map['submissionDate']),
    );
  }
}