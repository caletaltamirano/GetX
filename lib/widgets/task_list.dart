import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../theme/app_theme.dart';
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
///     `Obx` se reconstruye. El resto de la pantalla no se toca.
class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de sección, con la mezcla de pesos del diseño.
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 16, color: AppColors.textDark),
            children: [
              TextSpan(text: 'Mis '),
              TextSpan(
                text: 'Tareas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // El panel gris claro que contiene la lista.
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: AppRadius.panel,
            ),
            clipBehavior: Clip.antiAlias,
            child: Obx(() {
              // Caso 1: no hay tareas -> mensaje vacío.
              if (controller.tasks.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No hay tareas todavía.\nAgrega la primera arriba.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                );
              }

              // Caso 2: hay tareas -> lista scrolleable.
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: controller.tasks.length,
                separatorBuilder: (_, _) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  // Cada fila es un TaskTile con la tarea que le toca mostrar.
                  return TaskTile(task: task);
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
