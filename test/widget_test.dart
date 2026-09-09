import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/controllers/task_controller.dart';
import 'package:taskflow/models/task.dart';

/// Tests del laboratorio. Se corren con:  flutter test
///
/// Nota: aquí NO probamos la interfaz, solo el modelo y el controller (la
/// lógica de estado con GetX). Es lo más importante de revisar.
void main() {
  group('Task (modelo TF-1)', () {
    test('una tarea nueva arranca pendiente', () {
      final Task t = Task(title: 'Estudiar GetX');
      expect(t.title, 'Estudiar GetX');
      expect(t.completed, false);
    });

    test('dos tareas creadas seguidas tienen id distinto', () {
      final Task a = Task(title: 'A');
      final Task b = Task(title: 'B');
      expect(a.id, isNot(equals(b.id)));
    });
  });

  group('TaskController (estado con GetX - TF-2)', () {
    late TaskController controller;

    // `setUp` corre antes de CADA test -> controller limpio siempre.
    setUp(() {
      controller = TaskController();
    });

    test('arranca sin tareas', () {
      expect(controller.tasks, isEmpty);
      expect(controller.totalTasks, 0);
    });

    test('addTask agrega una tarea', () {
      controller.addTask('Leer sobre Obx');
      expect(controller.totalTasks, 1);
      expect(controller.tasks.first.title, 'Leer sobre Obx');
    });

    test('addTask ignora texto vacío o solo espacios', () {
      controller.addTask('');
      controller.addTask('   ');
      expect(controller.totalTasks, 0);
    });

    test('addTask recorta los espacios de los extremos', () {
      controller.addTask('  tarea con espacios  ');
      expect(controller.tasks.first.title, 'tarea con espacios');
    });

    test('toggleTask cambia entre pendiente y completada', () {
      controller.addTask('Practicar GetX');
      final id = controller.tasks.first.id;

      controller.toggleTask(id);
      expect(controller.tasks.first.completed, true);

      controller.toggleTask(id);
      expect(controller.tasks.first.completed, false);
    });

    test('deleteTask quita la tarea correcta', () {
      controller.addTask('A');
      controller.addTask('B');
      final idA = controller.tasks.first.id;

      controller.deleteTask(idA);

      expect(controller.totalTasks, 1);
      expect(controller.tasks.first.title, 'B');
    });

    test('los contadores derivados se calculan bien', () {
      controller.addTask('A');
      controller.addTask('B');
      controller.addTask('C');
      controller.toggleTask(controller.tasks.first.id); // completa "A"

      expect(controller.totalTasks, 3);
      expect(controller.completedTasks, 1);
      expect(controller.pendingTasks, 2);
    });
  });
}
