import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_board.dart';
import '../widgets/task_form.dart';
import '../widgets/task_list.dart';

/// ===========================================================================
///  PANTALLA: TaskScreen  (TF-6 - integración de todos los widgets)
/// ===========================================================================
///
/// Única pantalla de la app. Junta las 3 piezas del laboratorio dentro de una
/// tarjeta blanca grande sobre un fondo morado (estilo "dashboard").
///
///   ┌──────────────────────────────────────┐  fondo morado
///   │  ┌────────────────────────────────┐  │
///   │  │  Header: saludo + insignia     │  │  tarjeta blanca
///   │  │  StatsBoard  (TF-5)            │  │
///   │  │  TaskForm    (TF-3)            │  │
///   │  │  TaskList    (TF-4)            │  │
///   │  └────────────────────────────────┘  │
///   └──────────────────────────────────────┘
///
/// Punto para estudiar GetX:
///   - Esta pantalla NO crea el `TaskController` ni lo pasa por parámetro.
///   - Lo registra `TaskBinding` (ver main.dart) y cada widget lo pide solo
///     con `Get.find<TaskController>()`.
///   - Así los 3 widgets comparten el MISMO estado sin reenviar nada.
class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El color de fondo (morado) viene del tema.
      body: SafeArea(
        child: Center(
          // Limitamos el ancho para que en web/escritorio se vea como una
          // "app" centrada y no una barra gigante.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                // La tarjeta blanca grande con esquinas muy redondeadas y
                // sombra suave, igual que en el diseño de referencia.
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.card,
                  boxShadow: kSoftShadow,
                ),
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
                child: Column(
                  children: const [
                    _Header(),
                    SizedBox(height: 20),

                    // TF-5: tablero de estadísticas (reactivo).
                    StatsBoard(),
                    SizedBox(height: 18),

                    // TF-3: formulario para agregar tareas.
                    TaskForm(),
                    SizedBox(height: 16),

                    // TF-4: lista de tareas (reactiva). `Expanded` para que
                    // ocupe el espacio que sobra y pueda hacer scroll.
                    Expanded(child: TaskList()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Encabezado: saludo a la izquierda + insignia naranja con el número de
/// tareas pendientes a la derecha (igual que el "8" del diseño).
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Row(
      children: [
        // Avatar circular decorativo.
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.checklist_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 12),

        // Saludo. Mezclamos peso normal y negrita como en el diseño.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hola 👋',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, color: AppColors.textDark),
                  children: [
                    TextSpan(text: 'Task'),
                    TextSpan(
                      text: 'Flow',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Insignia naranja reactiva: cambia sola cuando cambian los pendientes.
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${controller.pendingTasks}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
