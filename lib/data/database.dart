import 'package:hive_flutter/hive_flutter.dart';

class TodoAppDatabase {
  var todoList = [];
  var box = Hive.box("mybox");

  void createList() {
    todoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void loadTasks() async {
    todoList = box.get("TodoList");
  }

  void updateTasks() {
    box.put("TodoList", todoList);
  }
}
