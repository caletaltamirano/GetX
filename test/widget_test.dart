import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/models/task.dart';

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
}
