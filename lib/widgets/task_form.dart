import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../theme/app_theme.dart';

/// ===========================================================================
///  WIDGET: TaskForm  (TF-3 - formulario para registrar una tarea)
/// ===========================================================================
///
/// Campo de texto redondeado + botón circular "+" para agregar una tarea.
///
/// Punto para estudiar GetX:
///   - Este widget ESCRIBE en el estado pero NO LO LEE.
///   - Por eso NO necesita `Obx`. `Obx` solo se usa donde hay que MOSTRAR
///     datos reactivos; aquí solo mandamos datos hacia el controller.
///
/// Es `StatefulWidget` únicamente por el `TextEditingController` (algo de
/// Flutter para manejar el texto del `TextField`), no por el estado de la app.
class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  /// Controla el texto que el usuario escribe (es de Flutter, no de GetX).
  final TextEditingController _textController = TextEditingController();

  /// Pedimos el `TaskController` a GetX. Ya fue registrado por `TaskBinding`,
  /// así que `Get.find` devuelve SIEMPRE la misma instancia que usan la lista
  /// y el tablero de estadísticas.
  final TaskController _taskController = Get.find<TaskController>();

  /// Se llama al tocar el botón o al dar "enter" en el teclado.
  void _submit() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    // 1. Mandamos el texto al controller -> él agrega la tarea a la RxList.
    // 2. GetX avisa a los `Obx` -> la lista y las estadísticas se actualizan.
    _taskController.addTask(text);

    // 3. Limpiamos el campo para la siguiente tarea.
    _textController.clear();
  }

  @override
  void dispose() {
    // Liberar el TextEditingController al destruir el widget (buena práctica).
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            textInputAction: TextInputAction.done,
            // Permite agregar la tarea presionando "enter".
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              hintText: 'Ej: Estudiar GetX',
              prefixIcon: Icon(Icons.edit_note_rounded, color: AppColors.textMuted),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Botón "+" redondeado (el estilo base viene del tema).
        SizedBox(
          height: 52,
          width: 52,
          child: IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Agregar tarea',
          ),
        ),
      ],
    );
  }
}
