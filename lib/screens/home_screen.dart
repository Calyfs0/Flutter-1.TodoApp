import 'package:flutter/material.dart';
import 'package:todoapp/screens/components/task_container.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List _taskList = [];

  var textController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _taskList[index][1] = !_taskList[index][1];
    });
  }

  void addNewTask() {
    var title = textController.text;
    if (title.isNotEmpty) {
      setState(() {
        _taskList.add([title, false]);
        textController.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
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
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    title: _taskList[index][0],
                    isTaskCompleted: _taskList[index][1],
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
