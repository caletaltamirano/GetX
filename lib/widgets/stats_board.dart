import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../theme/app_theme.dart';

/// ===========================================================================
///  WIDGET: StatsBoard  (TF-5 - tablero de estadísticas)
/// ===========================================================================
///
/// Muestra 3 tarjetas con degradado: Total / Pendientes / Completadas.
///
/// Punto para estudiar GetX:
///   - Los números vienen de getters del controller (`totalTasks`, etc.) que
///     NO son `.obs`. Aun así el tablero es reactivo porque esos getters leen
///     `tasks` DENTRO de este `Obx`.
///   - Un solo `Obx` envuelve las 3 tarjetas: cuando `tasks` cambia, solo esta
///     fila se vuelve a dibujar, no toda la pantalla.
class StatsBoard extends StatelessWidget {
  const StatsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia única del controller (registrada por TaskBinding).
    final controller = Get.find<TaskController>();

    return Obx(
      () => SizedBox(
        height: 116,
        child: Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.list_alt_rounded,
                label: 'Total',
                value: controller.totalTasks,
                gradient: AppColors.gradIndigo,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.pending_actions_rounded,
                label: 'Pendientes',
                value: controller.pendingTasks,
                gradient: AppColors.gradCoral,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_rounded,
                label: 'Completadas',
                value: controller.completedTasks,
                gradient: AppColors.gradGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta individual de estadística. Widget "tonto": recibe los datos ya
/// listos por parámetro y solo los dibuja. No sabe nada de GetX.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.gradient,
  });

  final IconData icon;
  final String label;
  final int value;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.panel,
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícono dentro de un círculo translúcido.
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const Spacer(),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
