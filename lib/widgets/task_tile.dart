import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

/**
 * Single row of [TaskList] representing one [Task].
 *
 * Shows a checkbox to toggle completion, the title (struck through when done)
 * and a delete button. It needs no [Obx] of its own because it already lives
 * inside the [Obx] of [TaskList]; it only calls controller methods and holds
 * no state.
 */
class TaskTile extends StatelessWidget {
  /**
   * Creates a tile for the given [task].
   */
  const TaskTile({super.key, required this.task});

  /**
   * The task this row renders.
   */
  final Task task;

  /**
   * Builds the [ListTile] and wires the checkbox, delete button and tap
   * gesture to the shared [TaskController].
   */
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (_) => controller.toggleTask(task.id),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
          color: task.completed ? Colors.grey : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        tooltip: 'Borrar tarea',
        onPressed: () => controller.deleteTask(task.id),
      ),
      onTap: () => controller.toggleTask(task.id),
    );
  }
}
