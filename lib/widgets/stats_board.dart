import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

/**
 * Reactive statistics board.
 *
 * Displays three cards: total, pending and completed tasks. The values come
 * from non-observable getters of [TaskController], yet the board stays reactive
 * because those getters read `tasks` inside this [Obx]. A single [Obx] wraps
 * the row, so only this section rebuilds when `tasks` changes.
 */
class StatsBoard extends StatelessWidget {
  /**
   * Creates the statistics board.
   */
  const StatsBoard({super.key});

  /**
   * Resolves the shared [TaskController] and builds the reactive row of
   * [_StatCard] widgets.
   */
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

/**
 * Presentational card for a single statistic.
 *
 * A "dumb" widget: it receives ready-to-render data through its constructor and
 * only paints it. It knows nothing about GetX.
 */
class _StatCard extends StatelessWidget {
  /**
   * Creates a statistic card from its [icon], [label], [value] and [color].
   */
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  /** Icon shown at the top of the card. */
  final IconData icon;

  /** Caption shown below the value. */
  final String label;

  /** Numeric value displayed prominently. */
  final int value;

  /** Accent color applied to the icon, value and label. */
  final Color color;

  /**
   * Builds the tinted [Card] with the icon, value and label stacked vertically.
   */
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
