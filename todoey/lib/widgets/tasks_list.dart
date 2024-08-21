import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, _) {
      return ListView.builder(
        itemCount: taskData.taskCount,
        itemBuilder: (context, index) {
          final task = taskData.tasks[index];
          return TaskTile(
            longPressCallback: () => taskData.deleteTask(task),
            isChecked: task.isDone,
            taskTitle: task.name,
            onChanged: () => taskData.updateTask(task),
          );
        },
      );
    });
  }
}
