class ScanHistory {
  final int? id;
  final String plantName;
  final String language;
  final String date;

  ScanHistory({
    this.id,
    required this.plantName,
    required this.language,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantName': plantName,
      'language': language,
      'date': date,
    };
  }

  factory ScanHistory.fromMap(Map<String, dynamic> map) {
    return ScanHistory(
      id: map['id'],
      plantName: map['plantName'],
      language: map['language'],
      date: map['date'],
    );
  }
}
