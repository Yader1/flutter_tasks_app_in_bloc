import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/services/guid_gen.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        const Text("Add Task", style: TextStyle(fontSize: 24.0)),
        const SizedBox(height: 10.0),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Title"),
            border: OutlineInputBorder()
          ),
          controller: titleController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                var task = Task(title: titleController.text, id: GUIDGen.generate());
                context.read<TasksBloc>().add(AddTask(task: task));
                Navigator.pop(context);
              },
              child: const Text("Add")
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
