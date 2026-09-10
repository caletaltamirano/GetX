import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/task_binding.dart';
import 'screens/task_screen.dart';

/**
 * Application entry point.
 *
 * Boots the Flutter framework and mounts [TaskFlowApp] as the root widget.
 */
void main() {
  runApp(const TaskFlowApp());
}

/**
 * Root widget of the application.
 *
 * Uses [GetMaterialApp] instead of the standard `MaterialApp` so that GetX is
 * enabled across the whole app. This activates dependency injection through
 * bindings, GetX navigation (`Get.to`, `Get.back`, ...) and helpers such as
 * `Get.snackbar` and `Get.dialog`.
 */
class TaskFlowApp extends StatelessWidget {
  /**
   * Creates the root widget.
   */
  const TaskFlowApp({super.key});

  /**
   * Builds the [GetMaterialApp] tree.
   *
   * Registers [TaskBinding] as the initial binding so the [TaskController] is
   * available before the first screen is rendered, applies a Material 3 theme
   * seeded from indigo and sets [TaskScreen] as the home screen.
   */
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      initialBinding: TaskBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskScreen(),
    );
  }
}
