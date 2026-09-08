/// Modelo mínimo de dominio de TaskFlow.
///
/// Representa una sola tarea. Es una clase de datos plana: no sabe nada de GetX
/// ni de la interfaz. El manejo de estado (la lista de tareas y sus cambios)
/// vive en el `TaskController` (historia TF-2).
class Task {
  Task({
    required this.title,
    this.completed = false,
  }) : id = '${DateTime.now().microsecondsSinceEpoch}-${_seq++}';

  /// Contador interno para garantizar ids únicos aunque se creen dos tareas
  /// dentro del mismo microsegundo.
  static int _seq = 0;

  /// Identificador único, usado para ubicar la tarea al alternar o eliminar.
  final String id;

  /// Texto descriptivo de la tarea.
  String title;

  /// `true` si la tarea ya fue completada, `false` si sigue pendiente.
  bool completed;

  @override
  String toString() => 'Task($id, "$title", completed: $completed)';
}
