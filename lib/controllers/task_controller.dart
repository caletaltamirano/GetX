import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  // Lista observable de tareas.
  final RxList<Task> tasks = <Task>[].obs;

  // Agregar una nueva tarea.
  void addTask(String title) {
    final cleanTitle = title.trim();

    if (cleanTitle.isEmpty) {
      return;
    }

    tasks.add(Task(title: cleanTitle));
  }

  // Eliminar una tarea por su ID.
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  // Cambiar una tarea entre pendiente y completada.
  void toggleTask(String id) {
    final index = tasks.indexWhere((task) => task.id == id);

    if (index == -1) {
      return;
    }

    tasks[index].completed = !tasks[index].completed;

    // Notifica a GetX que hubo un cambio en la lista.
    tasks.refresh();
  }

  // Cantidad total de tareas.
  int get totalTasks => tasks.length;

  // Cantidad de tareas pendientes.
  int get pendingTasks =>
      tasks.where((task) => !task.completed).length;

  // Cantidad de tareas completadas.
  int get completedTasks =>
      tasks.where((task) => task.completed).length;
}