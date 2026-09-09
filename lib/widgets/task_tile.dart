import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

/// ===========================================================================
///  WIDGET: TaskTile  (TF-4 - una fila de la lista de tareas)
/// ===========================================================================
///
/// Representa UNA tarea dentro de `TaskList`:
///   - un checkbox para marcarla como completada / pendiente
///   - el título (tachado si ya está completada)
///   - un botón de basura para borrarla
///
/// Punto para estudiar GetX:
///   - Este widget NO necesita su propio `Obx`. Ya vive dentro del `Obx` de
///     `TaskList`, así que cuando el controller hace `tasks.refresh()` toda
///     la lista (y por lo tanto este tile) se redibuja con los datos nuevos.
///   - El tile solo LLAMA a métodos del controller; no guarda estado.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  /// La tarea que esta fila tiene que mostrar.
  final Task task;

  @override
  Widget build(BuildContext context) {
    // Instancia única del controller (la misma para toda la app).
    final controller = Get.find<TaskController>();

    return ListTile(
      // Checkbox de la izquierda.
      leading: Checkbox(
        value: task.completed,
        // Al tocarlo, le pedimos al controller que cambie el estado.
        onChanged: (_) => controller.toggleTask(task.id),
      ),

      // Título. Si la tarea está completada, lo mostramos tachado y gris.
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
          color: task.completed ? Colors.grey : null,
        ),
      ),

      // Botón de borrar a la derecha.
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        tooltip: 'Borrar tarea',
        onPressed: () => controller.deleteTask(task.id),
      ),

      // Tocar en cualquier parte de la fila también alterna el estado.
      onTap: () => controller.toggleTask(task.id),
    );
  }
}
