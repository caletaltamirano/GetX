import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/task_binding.dart';
import 'screens/task_screen.dart';
import 'theme/app_theme.dart';

/// Punto de entrada de la app. Nada especial: arranca `TaskFlowApp`.
void main() {
  runApp(const TaskFlowApp());
}

/// ===========================================================================
///  RAÍZ DE LA APP: TaskFlowApp
/// ===========================================================================
///
/// Usamos `GetMaterialApp` en lugar del `MaterialApp` normal. Eso es lo que
/// "enciende" GetX en toda la aplicación y habilita:
///   - la inyección de dependencias (Bindings)
///   - la navegación de GetX (`Get.to`, `Get.back`, ...)
///   - utilidades como `Get.snackbar`, `Get.dialog`, etc.
///
/// Si dejáramos `MaterialApp`, `Obx` seguiría funcionando, pero perderíamos
/// Bindings y navegación de GetX.
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,

      /// `initialBinding` se ejecuta ANTES de mostrar la primera pantalla.
      /// `TaskBinding` registra el `TaskController`, así que cuando
      /// `TaskScreen` y sus widgets hagan `Get.find<TaskController>()`, el
      /// controller ya va a existir.
      initialBinding: TaskBinding(),

      /// Toda la apariencia (colores, sombras, bordes) vive en `AppTheme`.
      theme: AppTheme.light,

      home: const TaskScreen(),
    );
  }
}
