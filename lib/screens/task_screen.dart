import 'package:flutter/material.dart';

import '../widgets/stats_board.dart';
import '../widgets/task_form.dart';
import '../widgets/task_list.dart';

/// ===========================================================================
///  PANTALLA: TaskScreen  (TF-6 - integración de todos los widgets)
/// ===========================================================================
///
/// Esta es la única pantalla de la app. Junta las 3 piezas del laboratorio:
///
///   ┌─────────────────────────────┐
///   │  AppBar: "TaskFlow · GetX"   │
///   ├─────────────────────────────┤
///   │  StatsBoard  (TF-5)         │  <- Total / Pendientes / Completadas
///   │  TaskForm    (TF-3)         │  <- campo de texto + botón "+"
///   │  TaskList    (TF-4)         │  <- lista reactiva de tareas
///   └─────────────────────────────┘
///
/// Punto para estudiar GetX:
///   - Esta pantalla NO crea el `TaskController` ni lo pasa por parámetro.
///   - El controller lo registra `TaskBinding` (ver main.dart) y cada widget
///     lo pide por su cuenta con `Get.find<TaskController>()`.
///   - Resultado: los 3 widgets comparten EXACTAMENTE el mismo estado sin que
///     esta pantalla tenga que reenviar nada. Eso es la inyección de
///     dependencias de GetX.
class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

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
            // TF-5: tablero de estadísticas (reactivo).
            const StatsBoard(),
            const SizedBox(height: 16),

            // TF-3: formulario para agregar tareas.
            const TaskForm(),
            const SizedBox(height: 8),
            const Divider(),

            // TF-4: lista de tareas (reactiva).
            // `Expanded` para que la lista ocupe todo el espacio que sobra
            // y pueda hacer scroll.
            const Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }
}
