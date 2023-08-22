import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task){
    task.isDeleted! 
      ?ctx.read<TasksBloc>().add(DeleteTask(task: task))
      :ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.star_outline),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.0, decoration: task.isDone! ? TextDecoration.lineThrough : null)
                      ),
                      Text(DateFormat().add_yMEd().add_Hms().format(DateTime.now())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false ? (value){
                  context.read<TasksBloc>().add(UpdateTask(task: task));
                } : null,
              ),
              PopupMenuButton(itemBuilder: ((context)=>[
                PopupMenuItem(child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ), onTap: (){}),
                PopupMenuItem(child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Add to Booknarks'),
                ), onTap: (){}),
                PopupMenuItem(child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ), onTap: () => _removeOrDeleteTask(context, task))
              ]))
            ],
          ),
        ]
      ),
    );
  }
}

/*
ListTile(
      title: Text(task.title, overflow: TextOverflow.ellipsis, style: TextStyle(
        decoration: task.isDone! ? TextDecoration.lineThrough : null
      )),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted == false ? (value){
          context.read<TasksBloc>().add(UpdateTask(task: task));
        } : null,
      ),
      onLongPress: () => _removeOrDeleteTask(context, task),

    );
*/