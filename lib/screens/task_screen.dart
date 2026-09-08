import 'package:flutter/material.dart';

/// Pantalla principal de TaskFlow.
///
/// PROVISIONAL (historia TF-1): por ahora solo muestra un Scaffold vacío para
/// que la aplicación compile y corra. El contenido real lo agregan:
///   - TF-5: tablero de estadísticas (StatsBoard)
///   - TF-3: formulario de registro (TaskForm)
///   - TF-4: lista de tareas (TaskList)
///   - TF-6: integración final de todos los widgets aquí
class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow · GetX')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Base del proyecto lista (TF-1).\n'
            'Falta conectar TaskController, formulario, lista y tablero.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
