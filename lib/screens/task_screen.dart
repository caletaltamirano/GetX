import 'package:flutter/material.dart';

import '../widgets/stats_board.dart';
import '../widgets/task_form.dart';
import '../widgets/task_list.dart';

/**
 * Single screen of the application.
 *
 * Composes the three feature widgets in a column: [StatsBoard] (statistics),
 * [TaskForm] (add a task) and [TaskList] (reactive task list).
 *
 * The screen does not create or pass down the [TaskController]. Each widget
 * resolves it on its own through `Get.find<TaskController>()`, so all widgets
 * share the exact same state without prop drilling.
 */
class TaskScreen extends StatelessWidget {
  /**
   * Creates the task screen.
   */
  const TaskScreen({super.key});

  /**
   * Builds the [Scaffold] with an app bar and the padded column of widgets.
   *
   * The task list is wrapped in [Expanded] so it fills the remaining space and
   * becomes scrollable.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow · GetX'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const StatsBoard(),
            const SizedBox(height: 16),
            const TaskForm(),
            const SizedBox(height: 8),
            const Divider(),
            const Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }
}
