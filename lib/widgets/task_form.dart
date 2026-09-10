import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/**
 * Form widget used to register a new task.
 *
 * Renders a text field plus an add button. This widget only writes to the
 * state, it never reads it, so it does not need an [Obx].
 *
 * It is a [StatefulWidget] only because of the [TextEditingController], a
 * Flutter concern. The application state still lives entirely in
 * [TaskController].
 */
class TaskForm extends StatefulWidget {
  /**
   * Creates the task form.
   */
  const TaskForm({super.key});

  /**
   * Creates the mutable state for this widget.
   */
  @override
  State<TaskForm> createState() => _TaskFormState();
}

/**
 * Mutable state of [TaskForm].
 *
 * Owns the [TextEditingController] and forwards submitted text to the
 * [TaskController].
 */
class _TaskFormState extends State<TaskForm> {
  /**
   * Controls the text typed by the user in the [TextField].
   */
  final TextEditingController _textController = TextEditingController();

  /**
   * Shared [TaskController] instance registered by `TaskBinding`.
   */
  final TaskController _taskController = Get.find<TaskController>();

  /**
   * Handles a submission from the button or the keyboard action.
   *
   * Ignores empty input, otherwise sends the text to the controller and clears
   * the field.
   */
  void _submit() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    _taskController.addTask(text);
    _textController.clear();
  }

  /**
   * Disposes the [TextEditingController] when the widget is removed.
   */
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /**
   * Builds the row with the text field and the filled add button.
   */
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              labelText: 'Nueva tarea',
              hintText: 'Ej: Estudiar GetX',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: _submit,
          icon: const Icon(Icons.add),
          tooltip: 'Agregar tarea',
        ),
      ],
    );
  }
}
