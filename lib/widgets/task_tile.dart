import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

/// ===========================================================================
///  WIDGET: TaskTile  (TF-4 - una fila de la lista de tareas)
/// ===========================================================================
///
/// Representa UNA tarea dentro de `TaskList`:
///   - un control circular tipo checkbox para marcarla completada / pendiente
///   - el título (tachado y gris si ya está completada)
///   - un botón de basura para borrarla
///
/// Punto para estudiar GetX:
///   - Este widget NO necesita su propio `Obx`. Ya vive dentro del `Obx` de
///     `TaskList`, así que cuando el controller hace `tasks.refresh()` toda la
///     lista (y este tile) se redibuja con los datos nuevos.
///   - El tile solo LLAMA a métodos del controller; no guarda estado.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  /// La tarea que esta fila tiene que mostrar.
  final Task task;

  @override
  Widget build(BuildContext context) {
    // Instancia única del controller (la misma para toda la app).
    final controller = Get.find<TaskController>();
    final done = task.completed;

    return Material(
      color: Colors.white,
      borderRadius: AppRadius.tile,
      child: InkWell(
        borderRadius: AppRadius.tile,
        // Tocar la fila alterna pendiente / completada.
        onTap: () => controller.toggleTask(task.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // --- "Checkbox" circular ---------------------------------------
              // Es nuestro checkbox: círculo verde con check si está completada,
              // círculo con borde gris si está pendiente.
              GestureDetector(
                onTap: () => controller.toggleTask(task.id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: done ? const Color(0xFF20C997) : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: done ? const Color(0xFF20C997) : AppColors.textMuted,
                      width: 2,
                    ),
                  ),
                  child: done
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 12),

              // --- Título --------------------------------------------------
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    decoration: done ? TextDecoration.lineThrough : null,
                    color: done ? AppColors.textMuted : AppColors.textDark,
                  ),
                ),
              ),

              // --- Botón borrar -------------------------------------------
              IconButton(
                onPressed: () => controller.deleteTask(task.id),
                icon: const Icon(Icons.delete_outline_rounded),
                tooltip: 'Borrar tarea',
                // Anulamos el estilo morado del tema para este botón chico.
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.textMuted,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
