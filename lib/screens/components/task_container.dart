import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskContainer extends StatefulWidget {
  final String title;
  final bool isTaskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const TaskContainer({
    super.key,
    required this.title,
    required this.isTaskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(5),
          ),

          child: Row(
            children: [
              Checkbox(
                value: widget.isTaskCompleted,
                onChanged: widget.onChanged,
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: widget.isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
