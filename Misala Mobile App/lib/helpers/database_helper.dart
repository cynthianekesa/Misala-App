import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/plant_data.dart';
import '../models/scan_history.dart';
import '../models/community_submission.dart';
import '../models/conversation_post.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('misala.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plants(
        id TEXT PRIMARY KEY,
        nameEn TEXT NOT NULL,
        nameLuhya TEXT NOT NULL,
        descriptionEn TEXT NOT NULL,
        descriptionLuhya TEXT NOT NULL,
        preparationEn TEXT NOT NULL,
        preparationLuhya TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE scan_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantName TEXT NOT NULL,
        language TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE community_submissions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        englishName TEXT NOT NULL,
        scientificName TEXT,
        localName TEXT,
        ailmentTreated TEXT NOT NULL,
        preparationMethod TEXT NOT NULL,
        submittedBy TEXT NOT NULL,
        isVerified INTEGER DEFAULT 0,
        submissionDate TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE conversation_posts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        author TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        likes INTEGER DEFAULT 0,
        comments INTEGER DEFAULT 0,
        category TEXT DEFAULT 'General'
      )
    ''');
  }

  // Plant Data Methods
  Future<void> insertPlant(PlantInfo plant) async {
  final db = await instance.database;
  await db.insert('plants', plant.toMap());
}

  Future<List<PlantInfo>> getAllPlants() async {
  final db = await instance.database;
  final maps = await db.query('plants');
  return maps.map((map) => PlantInfo.fromMap(map)).toList();
}

  // Scan History Methods
  Future<void> insertScan(ScanHistory scan) async {
    final db = await instance.database;
    await db.insert('scan_history', scan.toMap());
  }

  Future<List<ScanHistory>> getScanHistory() async {
    final db = await instance.database;
    final maps = await db.query('scan_history', orderBy: 'date DESC');
    return maps.map((map) => ScanHistory.fromMap(map)).toList();
  }

  // Community Submission Methods
  Future<int> insertCommunitySubmission(CommunitySubmission submission) async {
    final db = await instance.database;
    return await db.insert('community_submissions', submission.toMap());
  }

  Future<List<CommunitySubmission>> getCommunitySubmissions() async {
    final db = await instance.database;
    final maps = await db.query('community_submissions', orderBy: 'submissionDate DESC');
    return maps.map((map) => CommunitySubmission.fromMap(map)).toList();
  }

  Future<List<CommunitySubmission>> getVerifiedSubmissions() async {
    final db = await instance.database;
    final maps = await db.query(
      'community_submissions',
      where: 'isVerified = ?',
      whereArgs: [1],
      orderBy: 'submissionDate DESC',
    );
    return maps.map((map) => CommunitySubmission.fromMap(map)).toList();
  }

  Future<List<CommunitySubmission>> getPendingSubmissions() async {
    final db = await instance.database;
    final maps = await db.query(
      'community_submissions',
      where: 'isVerified = ?',
      whereArgs: [0],
      orderBy: 'submissionDate DESC',
    );
    return maps.map((map) => CommunitySubmission.fromMap(map)).toList();
  }

  Future<void> verifySubmission(int id) async {
    final db = await instance.database;
    await db.update(
      'community_submissions',
      {'isVerified': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Conversation Post Methods
  Future<int> insertConversationPost(ConversationPost post) async {
    final db = await instance.database;
    return await db.insert('conversation_posts', post.toMap());
  }

  Future<List<ConversationPost>> getConversationPosts() async {
    final db = await instance.database;
    final maps = await db.query('conversation_posts', orderBy: 'timestamp DESC');
    return maps.map((map) => ConversationPost.fromMap(map)).toList();
  }

  Future<void> likePost(int postId) async {
    final db = await instance.database;
    await db.rawUpdate(
      'UPDATE conversation_posts SET likes = likes + 1 WHERE id = ?',
      [postId],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}