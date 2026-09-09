import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/// Tablero de estadísticas (TF-5). Un único Obx: cuando `tasks` cambia en
/// TaskController, solo estas 3 tarjetas se reconstruyen.
class StatsBoard extends StatelessWidget {
  const StatsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.list_alt,
              label: 'Total',
              value: controller.totalTasks,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _StatCard(
              icon: Icons.pending_actions,
              label: 'Pendientes',
              value: controller.pendingTasks,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _StatCard(
              icon: Icons.check_circle,
              label: 'Completadas',
              value: controller.completedTasks,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}