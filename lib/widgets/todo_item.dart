import 'package:flutter/material.dart';

import '../model/todo.dart';
import 'date_picker.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            // print('Clicked on Todo Item.');
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Theme.of(context).colorScheme.primary,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(
            todo.todoText,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inverseSurface,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).iconTheme.color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 18,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // print('Clicked on delete icon');
                    onDeleteItem(todo.id);
                  },
                ),
                DatePickerIcon(
                  notificationText: todo.todoText,
                ),
              ],
            ),
          ),
        ));
  }
}
