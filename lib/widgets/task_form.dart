import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/// ===========================================================================
///  WIDGET: TaskForm  (TF-3 - formulario para registrar una tarea)
/// ===========================================================================
///
/// Este widget es un campo de texto + un botón para agregar una tarea nueva.
///
/// Punto para estudiar GetX:
///   - Este widget ESCRIBE en el estado pero NO LO LEE.
///   - Por eso NO necesita `Obx`. `Obx` solo se usa donde hay que MOSTRAR
///     datos reactivos; aquí solo mandamos datos hacia el controller.
///
/// Es `StatefulWidget` únicamente por el `TextEditingController` (algo propio
/// de Flutter para manejar el texto del `TextField`), no por el estado de la
/// app. El estado de la app sigue viviendo 100% en `TaskController`.
class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  /// Controla el texto que el usuario escribe en el `TextField`.
  /// (Es de Flutter, no de GetX.)
  final TextEditingController _textController = TextEditingController();

  /// Pedimos el `TaskController` a GetX. Ya fue registrado por `TaskBinding`,
  /// así que `Get.find` nos devuelve SIEMPRE la misma instancia que usan la
  /// lista y el tablero de estadísticas.
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
    // Liberar el TextEditingController cuando el widget se destruye
    // (buena práctica de Flutter para no dejar memoria colgada).
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
            // Permite agregar la tarea presionando "enter" en el teclado.
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              labelText: 'Nueva tarea',
              hintText: 'Ej: Estudiar GetX',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Botón con ícono de "+".
        IconButton.filled(
          onPressed: _submit,
          icon: const Icon(Icons.add),
          tooltip: 'Agregar tarea',
        ),
      ],
    );
  }
}
