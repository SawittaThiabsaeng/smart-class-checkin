import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static const String _databaseName = 'attendance.db';
  static const int _databaseVersion = 1;
  static const String tableName = 'attendance_records';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentId TEXT NOT NULL,
            checkinTime TEXT,
            checkinLocation TEXT,
            checkoutTime TEXT,
            checkoutLocation TEXT,
            mood INTEGER,
            previousTopic TEXT,
            expectedTopic TEXT,
            learnedToday TEXT,
            feedback TEXT
          )
        ''');
      },
    );
  }

  Future<int> saveCheckIn({
    required String studentId,
    required DateTime checkinTime,
    required String checkinLocation,
    int? mood,
    String? previousTopic,
    String? expectedTopic,
  }) async {
    final Database db = await database;

    return db.insert(tableName, {
      'studentId': studentId,
      'checkinTime': checkinTime.toIso8601String(),
      'checkinLocation': checkinLocation,
      'mood': mood,
      'previousTopic': previousTopic,
      'expectedTopic': expectedTopic,
      'checkoutTime': null,
      'checkoutLocation': null,
      'learnedToday': null,
      'feedback': null,
    });
  }

  Future<int> saveCheckOut({
    required String studentId,
    required DateTime checkoutTime,
    required String checkoutLocation,
    String? learnedToday,
    String? feedback,
  }) async {
    final Database db = await database;

    return db.rawUpdate(
      '''
      UPDATE $tableName
      SET checkoutTime = ?,
          checkoutLocation = ?,
          learnedToday = ?,
          feedback = ?
      WHERE id = (
        SELECT id FROM $tableName
        WHERE studentId = ? AND checkoutTime IS NULL
        ORDER BY checkinTime DESC
        LIMIT 1
      )
      ''',
      [
        checkoutTime.toIso8601String(),
        checkoutLocation,
        learnedToday,
        feedback,
        studentId,
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getAllAttendanceRecords() async {
    final Database db = await database;
    return db.query(tableName, orderBy: 'id DESC');
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
