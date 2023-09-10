import 'package:flutter/material.dart';
import 'package:provider_todo_app/Utils/task_database.dart';

import '../Model/task_model.dart';

class TaskProvider with ChangeNotifier {
  TaskDatabase taskDatabase = TaskDatabase();

  List<Task> _task = [];

  List<Task> get tasks => _task;

  Future<void> fetchTasks() async {
    await taskDatabase.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await taskDatabase.insertTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await taskDatabase.deleteTask(id);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await taskDatabase.updateTask(task);
    await fetchTasks();
  }
}
