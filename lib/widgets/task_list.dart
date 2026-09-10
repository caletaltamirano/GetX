import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import 'task_tile.dart';

/**
 * Reactive list of tasks.
 *
 * Wraps its content in `Obx(() => ...)` and reads `controller.tasks` inside it.
 * GetX records the dependency, so only this widget rebuilds when a task is
 * added, removed or updated; the rest of the screen is untouched.
 */
class TaskList extends StatelessWidget {
  /**
   * Creates the task list.
   */
  const TaskList({super.key});

  /**
   * Builds the reactive content.
   *
   * Shows an empty-state message when there are no tasks, otherwise renders a
   * scrollable [ListView.separated] of [TaskTile] rows.
   */
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Obx(() {
      if (controller.tasks.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'No hay tareas todavía.\nAgrega la primera arriba.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return ListView.separated(
        itemCount: controller.tasks.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return TaskTile(task: task);
        },
      );
    });
  }
}
