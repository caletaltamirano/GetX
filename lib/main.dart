import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/task_screen.dart';

void main() {
  runApp(const TaskFlowApp());
}

/// Raíz de la aplicación.
///
/// Usamos [GetMaterialApp] (en vez de `MaterialApp`) para habilitar el manejo
/// de rutas, los bindings y la inyección de dependencias de GetX.
///
/// El `initialBinding` que registra el `TaskController` se agrega en la
/// historia TF-6 (integración).
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskScreen(),
    );
  }
}
