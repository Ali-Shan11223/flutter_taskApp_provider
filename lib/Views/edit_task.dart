import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/Model/task_model.dart';
import 'package:provider_todo_app/Provider/task_provider.dart';

import '../Widgets/text_field.dart';

class EditTask extends StatefulWidget {
  final String title;
  final String description;
  final int id;
  
  const EditTask({
    super.key,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            MyTextfield(
              controller: titleController,
              hint: 'Enter title',
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(controller: descController, hint: 'Enter Description'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                      Task(
                          id: widget.id,
                          title: titleController.text,
                          description: descController.text));
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
