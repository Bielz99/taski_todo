import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:taski_todo/models/task_model.dart';

class TaskRepository {
  static const String _tableName = 'tasks';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            isCompleted INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    final db = await database;
    try {
      await db.insert(_tableName, task.toMap());
      print('Task added: ${task.toMap()}');
    } catch (e) {
      print('Error inserting task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
