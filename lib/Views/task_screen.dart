import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/Provider/task_provider.dart';

import 'add_task.dart';
import 'edit_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    print('task screen build');
    final provider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder(
            future: provider.fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                  final tasks = taskProvider.tasks;
                  return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            subtitle: Text(task.description),
                            trailing: IconButton(
                              onPressed: () {
                                taskProvider.deleteTask(task.id!);
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTask(
                                        id: task.id!,
                                        title: task.title,
                                        description: task.description,
                                      )));
                            },
                          ),
                        );
                      });
                });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTask()));
        },
        label: const Text('Add Task'),
        icon: const Icon(Icons.note),
      ),
    );
  }
}
