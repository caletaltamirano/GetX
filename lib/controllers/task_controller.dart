import 'package:get/get.dart';

import '../models/task.dart';

/// ===========================================================================
///  CONTROLLER: TaskController  (el corazón del estado con GetX)
/// ===========================================================================
///
/// Un "controller" en GetX es la clase donde vive:
///   1. El ESTADO  -> los datos que cambian (aquí: la lista de tareas).
///   2. La LÓGICA  -> los métodos que modifican ese estado (agregar, borrar...).
///
/// Los widgets NO guardan datos. Solo:
///   - piden el controller con `Get.find<TaskController>()`
///   - llaman a sus métodos cuando el usuario toca algo
///   - se reconstruyen solos cuando el estado cambia (gracias a `Obx`)
///
/// Extender `GetxController` nos da el ciclo de vida de GetX (onInit, onClose)
/// y permite que GetX lo cree/destruya automáticamente mediante un Binding.
class TaskController extends GetxController {
  /// -------------------------------------------------------------------------
  ///  ESTADO REACTIVO
  /// -------------------------------------------------------------------------
  ///
  /// `<Task>[]` es una lista normal de Dart.
  /// El `.obs` al final la convierte en una lista OBSERVABLE (`RxList<Task>`).
  ///
  /// "Observable" significa: GetX vigila esta lista. Cada vez que le agregas,
  /// le quitas o la reordenas, GetX avisa a todos los `Obx(() => ...)` que
  /// estén leyendo `tasks` para que se vuelvan a dibujar.
  ///
  /// Es `final` porque la CAJA (la RxList) siempre es la misma; lo que cambia
  /// es su CONTENIDO.
  final RxList<Task> tasks = <Task>[].obs;

  /// -------------------------------------------------------------------------
  ///  LÓGICA DE NEGOCIO
  /// -------------------------------------------------------------------------

  /// Agrega una tarea nueva a partir de un texto.
  ///
  /// `tasks.add(...)` modifica la lista observable -> GetX detecta el cambio
  /// -> la lista en pantalla y el tablero de estadísticas se actualizan solos.
  void addTask(String title) {
    final cleanTitle = title.trim();

    // Si el usuario mandó texto vacío o solo espacios, no hacemos nada.
    if (cleanTitle.isEmpty) return;

    tasks.add(Task(title: cleanTitle));
  }

  /// Borra la tarea que tenga ese `id`.
  ///
  /// `removeWhere` quita todos los elementos que cumplan la condición.
  /// Al modificar la lista observable, la UI reacciona automáticamente.
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  /// Cambia una tarea entre "pendiente" y "completada".
  void toggleTask(String id) {
    final index = tasks.indexWhere((task) => task.id == id);

    // `indexWhere` devuelve -1 si no encontró nada. En ese caso, salimos.
    if (index == -1) return;

    // OJO: aquí cambiamos un campo DENTRO de un objeto Task.
    // La RxList vigila si le agregas o quitas elementos, pero NO vigila los
    // cambios internos de cada objeto. Por eso, después de mutar `completed`,
    // llamamos a `tasks.refresh()` para forzar el aviso a los `Obx`.
    tasks[index].completed = !tasks[index].completed;
    tasks.refresh();
  }

  /// -------------------------------------------------------------------------
  ///  DATOS DERIVADOS (getters)
  /// -------------------------------------------------------------------------
  ///
  /// Estos getters NO llevan `.obs`. Son cálculos normales sobre `tasks`.
  ///
  /// ¿Por qué son reactivos igual? Porque adentro leen `tasks`. Si los usas
  /// dentro de un `Obx(() => Text('${controller.totalTasks}'))`, GetX ve que
  /// ese `Obx` depende de `tasks` y lo reconstruye cuando la lista cambia.
  /// Así no hay que duplicar el estado: una sola fuente de verdad (`tasks`).

  /// Cantidad total de tareas.
  int get totalTasks => tasks.length;

  /// Cantidad de tareas que todavía están pendientes.
  int get pendingTasks => tasks.where((task) => !task.completed).length;

  /// Cantidad de tareas ya completadas.
  int get completedTasks => tasks.where((task) => task.completed).length;
}
