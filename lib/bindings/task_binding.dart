import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/// ===========================================================================
///  BINDING: TaskBinding  (inyección de dependencias con GetX)
/// ===========================================================================
///
/// Un "Binding" es el lugar donde le decimos a GetX QUÉ controllers necesita
/// una pantalla y CÓMO crearlos. Es como la "lista de ingredientes" de la
/// pantalla.
///
/// ¿Por qué usar un Binding en vez de crear el controller a mano?
///   - Separa la creación del estado de los widgets (la UI queda más limpia).
///   - GetX se encarga de crear el controller cuando se entra a la pantalla
///     y de destruirlo cuando se sale (maneja memoria por vos).
///   - Cualquier widget de esa pantalla puede pedir el controller con
///     `Get.find<TaskController>()` sin preocuparse de quién lo creó.
///
/// Este Binding se conecta en `main.dart` con:
///     GetMaterialApp(initialBinding: TaskBinding(), ...)
class TaskBinding extends Bindings {
  @override
  void dependencies() {
    /// `Get.lazyPut` registra el controller pero NO lo crea todavía.
    /// Se crea la PRIMERA vez que alguien hace `Get.find<TaskController>()`.
    ///
    /// Alternativas:
    ///   - `Get.put(TaskController())`     -> lo crea ya mismo (inmediato).
    ///   - `Get.lazyPut(() => ...)`        -> lo crea cuando se necesite (perezoso).
    ///
    /// Para esta app cualquiera de las dos sirve; usamos `lazyPut` porque es
    /// la forma recomendada dentro de un Binding.
    Get.lazyPut<TaskController>(() => TaskController());
  }
}
