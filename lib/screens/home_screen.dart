import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/screens/components/task_container.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  TodoAppDatabase db = TodoAppDatabase();
  var box = Hive.box("mybox");

  @override
  void initState() {
    if (box.get("TodoList") == null) {
      db.createList();
    } else {
      db.loadTasks();
    }
    super.initState();
  }

  var textController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateTasks();
  }

  void addNewTask() {
    var title = textController.text;
    if (title.isNotEmpty) {
      setState(() {
        db.todoList.add([title, false]);
        textController.clear();
      });
      db.updateTasks();
    }
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            "T A S K S",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      scrollPhysics: ClampingScrollPhysics(),
                      controller: textController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        labelText: "Add New Task",
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                IconButton(onPressed: addNewTask, icon: Icon(Icons.add)),
              ],
            ),

            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: db.todoList.length,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    title: db.todoList[index][0],
                    isTaskCompleted: db.todoList[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
