import 'package:get/get.dart';

import '../models/task.dart';

/**
 * Central state holder for the application.
 *
 * Holds the reactive list of tasks and the business logic that mutates it
 * (add, delete, toggle). Widgets never store data themselves: they read this
 * controller through `Get.find<TaskController>()`, call its methods and rebuild
 * automatically via `Obx` when the state changes.
 *
 * Extends [GetxController] to gain the GetX lifecycle and to be created and
 * disposed automatically by a binding.
 */
class TaskController extends GetxController {
  /**
   * Reactive list of tasks and single source of truth of the app.
   *
   * The `.obs` suffix turns a regular list into an observable [RxList]. Any
   * add, remove or reorder notifies every `Obx` that reads [tasks] so it can
   * rebuild. The reference is `final`; only its contents change.
   */
  final RxList<Task> tasks = <Task>[].obs;

  /**
   * Creates a new task from [title] and appends it to [tasks].
   *
   * The title is trimmed first; empty or whitespace-only input is ignored.
   * Mutating the observable list makes the UI react automatically.
   */
  void addTask(String title) {
    final cleanTitle = title.trim();

    if (cleanTitle.isEmpty) return;

    tasks.add(Task(title: cleanTitle));
  }

  /**
   * Removes the task whose [Task.id] matches [id].
   *
   * If no task matches, the list is left unchanged.
   */
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  /**
   * Toggles the task identified by [id] between pending and completed.
   *
   * Does nothing if the id is not found. Because [RxList] only tracks
   * structural changes and not mutations of an item's fields, `tasks.refresh()`
   * is called afterwards to notify every `Obx`.
   */
  void toggleTask(String id) {
    final index = tasks.indexWhere((task) => task.id == id);

    if (index == -1) return;

    tasks[index].completed = !tasks[index].completed;
    tasks.refresh();
  }

  /**
   * Total number of tasks.
   */
  int get totalTasks => tasks.length;

  /**
   * Number of tasks that are still pending.
   */
  int get pendingTasks => tasks.where((task) => !task.completed).length;

  /**
   * Number of tasks that are already completed.
   */
  int get completedTasks => tasks.where((task) => task.completed).length;
}
