import 'package:shared_preferences/shared_preferences.dart';

class ToDo {
  String id;
  String todoText;
  bool isDone;
  static int todoCount = 0;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  ToDo.empty()
      : id = '',
        todoText = '',
        isDone = false;

  static Future saveTodoState(String key, bool state) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, state);
  }

  static Future readTodoState(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future removeTodoState(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future saveTodo(String key, String todo) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, todo);
  }

  static Future<String?> readTodo(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future removeTodo(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<List<ToDo>> getTodos() async {
    List<ToDo> todos = [];

    String? todoCountStr = await readTodo('todoCount');
    if (todoCountStr != null) {
      int todoCount = int.parse(todoCountStr);
      for (int i = 0; i < todoCount; i++) {
        ToDo todo = ToDo.empty();
        String? todoText = await readTodo(i.toString());
        if (todoText != null) {
          todo.todoText = todoText;
          todo.id = i.toString();

          bool? isTodoDone = await readTodoState('${i.toString()}d');
          if (isTodoDone != null) {
            todo.isDone = isTodoDone;
            todos.add(todo);
          }
        }
      }
    }

    return todos;
  }
}
