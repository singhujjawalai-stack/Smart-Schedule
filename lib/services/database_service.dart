import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';
import '../models/reminder_model.dart';
import '../models/completion_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('smart_schedule.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE tasks (id TEXT PRIMARY KEY, title TEXT, type TEXT, details TEXT, photo_path TEXT, created_at INTEGER)');
    await db.execute('CREATE TABLE reminders (task_id TEXT PRIMARY KEY, mode TEXT, silent INTEGER, recurrence TEXT, custom_interval INTEGER, next_trigger INTEGER)');
    await db.execute('CREATE TABLE logs (id TEXT PRIMARY KEY, task_id TEXT, completed_at INTEGER, dosage_taken INTEGER, missed INTEGER)');
  }

  // CRUD for tasks
  Future<String> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', {
      'id': task.id,
      'title': task.title,
      'type': task.type,
      'details': task.description,
      'photo_path': task.photoPath,
      'created_at': task.createdAt.millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    return task.id;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final maps = await db.query('tasks');
    return maps.map((m) => Task(
      id: m['id'] as String,
      title: m['title'] as String,
      type: m['type'] as String,
      description: (m['details'] as String?) ?? '',
      photoPath: m['photo_path'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(m['created_at'] as int),
    )).toList();
  }

  // Reminders
  Future<void> insertReminder(ReminderSetting r) async {
    final db = await database;
    await db.insert('reminders', {
      'task_id': r.taskId,
      'mode': r.mode,
      'silent': r.silent ? 1 : 0,
      'recurrence': r.recurrence,
      'custom_interval': r.customInterval,
      'next_trigger': r.nextTrigger?.millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Logs
  Future<void> insertLog(CompletionLog log) async {
    final db = await database;
    await db.insert('logs', {
      'id': log.id,
      'task_id': log.taskId,
      'completed_at': log.completedAt.millisecondsSinceEpoch,
      'dosage_taken': log.dosageTaken,
      'missed': log.missed ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CompletionLog>> getLogsForTask(String taskId) async {
    final db = await database;
    final maps = await db.query('logs', where: 'task_id = ?', whereArgs: [taskId]);
    return maps.map((m) => CompletionLog(
      id: m['id'] as String,
      taskId: m['task_id'] as String,
      completedAt: DateTime.fromMillisecondsSinceEpoch(m['completed_at'] as int),
      dosageTaken: m['dosage_taken'] as int,
      missed: (m['missed'] as int) == 1,
    )).toList();
  }
}
