import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:taski_todo/models/task_model.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  static final TaskRepositoryImpl _instance = TaskRepositoryImpl._internal();
  static Database? _database;

  factory TaskRepositoryImpl() {
    return _instance;
  }

  TaskRepositoryImpl._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        subtitle TEXT,
        isChecked INTEGER
      )
    ''');
  }

  @override
  Future<int> insertTask(Task task) async {
    Database db = await database;
    return await db.insert('tasks', task.toMap());
  }

  @override
  Future<List<Task>> getTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isChecked = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isChecked = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<int> updateTask(Task task) async {
    Database db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteAllTasks() async {
    Database db = await database;

    return await db.delete('tasks');
  }
}
