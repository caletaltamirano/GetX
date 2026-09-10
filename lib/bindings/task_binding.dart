import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/**
 * Dependency injection binding for the task feature.
 *
 * Declares which controllers a screen needs and how to build them. Connected in
 * `main.dart` through `GetMaterialApp(initialBinding: TaskBinding(), ...)`.
 * GetX creates the controller when the screen is entered and disposes it when
 * the screen is left.
 */
class TaskBinding extends Bindings {
  /**
   * Registers the [TaskController] with GetX.
   *
   * Uses `Get.lazyPut`, so the controller is instantiated on the first
   * `Get.find<TaskController>()` call rather than immediately.
   */
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}
