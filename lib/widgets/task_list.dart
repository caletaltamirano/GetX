import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import 'task_tile.dart';

/// ===========================================================================
///  WIDGET: TaskList  (TF-4 - lista reactiva de tareas)
/// ===========================================================================
///
/// Muestra todas las tareas del `TaskController`. Es el ejemplo más claro de
/// reactividad con GetX en esta app.
///
/// Idea central:
///   - Envolvemos el contenido en `Obx(() => ...)`.
///   - Adentro leemos `controller.tasks`.
///   - GetX "anota" que este `Obx` depende de `tasks`.
///   - Cuando el controller agrega / borra / actualiza una tarea, SOLO este
///     `Obx` se reconstruye. El resto de la pantalla (AppBar, formulario...)
///     no se toca. Eso es lo que hace a GetX eficiente.
class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    // Pedimos la instancia única del controller (creada por TaskBinding).
    final controller = Get.find<TaskController>();

    // Todo lo reactivo va dentro de este Obx.
    return Obx(() {
      // Caso 1: no hay tareas -> mensaje vacío.
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

      // Caso 2: hay tareas -> las dibujamos en una lista scrolleable.
      return ListView.separated(
        itemCount: controller.tasks.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          // Cada fila es un TaskTile. Le pasamos la tarea que le toca mostrar.
          return TaskTile(task: task);
        },
      );
    });
  }
}
