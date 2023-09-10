import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../Model/task_model.dart';

class TaskDatabase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    try {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'tasks.db');
      var database = await openDatabase(path, version: 1, onCreate: _onCreate);
      return database;
    } catch (e) {
      throw Exception('Failed to create database: $e');
    }
  }

  Future<void> _onCreate(Database database, int version) async {
    try {
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)');
    } catch (e) {
      throw Exception('Failed to create table: $e');
    }
  }

  Future<List<Task>> getTasks() async {
    try {
      var dbClient = await database;
      final List<Map<String, dynamic>> result = await dbClient!.query('tasks');
      return result.map((e) => Task.fromMap(e)).toList();
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }

  Future<void> insertTask(Task task) async {
    try {
      var dbClient = await database;
      dbClient!.insert('tasks', task.toMap());
    } catch (e) {
      throw Exception('Failed to insert task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      var dbClient = await database;
      dbClient!
          .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      var dbClient = await database;
      dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
