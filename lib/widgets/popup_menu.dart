import 'package:flutter/material.dart';

import '../models/task.dart';

class PopuMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;
  
  const PopuMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: task.isDeleted == false ? ((context)=>[
      PopupMenuItem(child: TextButton.icon(
        onPressed: editTaskCallback,
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ), onTap: null),
      PopupMenuItem(child: TextButton.icon(
        onPressed: null,
        icon: task.isFavorite == false ? const Icon(Icons.bookmark_add_outlined) : const Icon(Icons.bookmark_remove),
        label: task.isFavorite == false ? const Text('Add to \nBooknarks') : const Text('Remove from \nBooknarks'),
      ), onTap: likeOrDislikeCallback),
      PopupMenuItem(child: TextButton.icon(
        onPressed: null,
        icon: const Icon(Icons.delete),
        label: const Text('Delete'),
      ), onTap: cancelOrDeleteCallback)
    ]) : (context)=>[
      PopupMenuItem(child: TextButton.icon(
        onPressed: null,
        icon: const Icon(Icons.restore_from_trash),
        label: const Text('Restore'),
      ), onTap: restoreTaskCallback),
      PopupMenuItem(child: TextButton.icon(
        onPressed: null,
        icon: const Icon(Icons.delete_forever),
        label: const Text('Delete Forever'),
      ), onTap: cancelOrDeleteCallback)
    ]);
  }
}