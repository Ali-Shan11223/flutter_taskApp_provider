import 'package:flutter/material.dart';
import '../../../Model/task_model.dart';
import '../../../Provider/task_provider.dart';
import '../../edit_task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.taskProvider
  });

  final Task task;
  final TaskProvider taskProvider;

  @override
  Widget build(BuildContext context) {
    
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
  }
}