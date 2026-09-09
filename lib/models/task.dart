/// ===========================================================================
///  MODELO: Task
/// ===========================================================================
///
/// Esto es una "clase de datos" normal de Dart. Representa UNA sola tarea.
///
/// Punto importante para estudiar GetX:
///   - Este archivo NO importa GetX.
///   - El modelo no sabe nada de la interfaz ni del estado de la app.
///   - GetX solo entra en juego en el `TaskController`, que es quien guarda
///     la LISTA de tareas y avisa a los widgets cuando esa lista cambia.
///
/// Regla mental: el modelo = "qué es una tarea".
///               el controller = "cómo cambian las tareas y quién se entera".
class Task {
  Task({
    required this.title,
    this.completed = false,
  }) : id = '${DateTime.now().microsecondsSinceEpoch}-${_seq++}';

  /// Contador interno de la clase (es `static`, o sea compartido por todas las
  /// instancias). Sirve para que dos tareas creadas en el mismo microsegundo
  /// igual tengan un `id` distinto.
  static int _seq = 0;

  /// Identificador único de la tarea.
  /// Lo usamos para ubicarla dentro de la lista cuando hay que marcarla como
  /// completada o borrarla. Es `final`: nunca cambia una vez creada la tarea.
  final String id;

  /// Texto que describe la tarea (ej: "Estudiar GetX").
  /// No es `final` porque, en teoría, se podría editar.
  String title;

  /// Estado de la tarea:
  ///   - `false` -> pendiente
  ///   - `true`  -> completada
  bool completed;

  /// Representación en texto, útil solo para depurar (print en consola).
  @override
  String toString() => 'Task($id, "$title", completed: $completed)';
}
