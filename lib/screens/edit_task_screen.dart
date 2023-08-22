import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/services/guid_gen.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  
  const EditTaskScreen({
    Key? key, 
    required this.oldTask,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        const Text("Edit Task", style: TextStyle(fontSize: 24.0)),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              label: Text("Title"),
              border: OutlineInputBorder()
            ),
            controller: titleController,
          ),
        ),
        TextField(
          autofocus: true,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            label: Text("Description"),
            border: OutlineInputBorder()
          ),
          controller: descriptionController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                var editTask = Task(
                  title: titleController.text, 
                  description: descriptionController.text, 
                  id: oldTask.id,
                  isFavorite: oldTask.isFavorite,
                  isDone: false,
                  date: DateTime.now().toString()
                );
                context.read<TasksBloc>().add(EditTask(oldTask: oldTask, newTask: editTask));
                Navigator.pop(context);
              },
              child: const Text("Save")
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cancelar"),
            ),
          ],
        ),
      ]),
    );
  }
}
