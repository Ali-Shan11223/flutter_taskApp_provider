import 'package:flutter/material.dart';
import 'package:provider_todo_app/Views/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      home: const TaskScreen(),
    );
  }
}
