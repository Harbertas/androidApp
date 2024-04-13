import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<ToDo> todoList = [];
  final todoController = TextEditingController();

  TodoProvider() {
    // Call an async method to initialize todoList
    _initializeTodoList();
    _initializeTodoCount();
  }

  Future<void> _initializeTodoCount() async {
    String? receivedTodoCount = await ToDo.readTodo('todoCount');
    if (receivedTodoCount != null) {
      ToDo.todoCount = int.parse(receivedTodoCount.toString());
    } else {
      ToDo.todoCount = 0;
    }
  }

  Future<void> _initializeTodoList() async {
    List<ToDo> todos = await ToDo.getTodos();
    todoList = todos;
    notifyListeners();
  }

  void handleToDoChange(ToDo todo) {
    todo.isDone = !todo.isDone;
    String isDoneKey = '${todo.id}d';
    ToDo.saveTodoState(isDoneKey, todo.isDone);
    notifyListeners();
  }

  void deleteToDoItem(String id) {
    todoList.removeWhere((item) => item.id == id);
    ToDo.removeTodo(id);
    ToDo.removeTodoState('${id.toString()}d');
    notifyListeners();
  }

  void addToDoItem(String toDo) {
    ToDo todo;
    if (toDo.isNotEmpty) {
      todoList.add(todo = ToDo(
        id: ToDo.todoCount.toString(),
        todoText: toDo,
      ));
      todoController.clear();
      ToDo.saveTodo(todo.id, todo.todoText);
      ToDo.saveTodoState('${todo.id}d', false);
      ToDo.todoCount++;
      ToDo.saveTodo('todoCount', ToDo.todoCount.toString());
      notifyListeners();
    }
  }
}
