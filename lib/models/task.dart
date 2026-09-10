/**
 * Plain data model that represents a single task.
 *
 * This class is framework-agnostic: it does not depend on GetX or Flutter. It
 * only describes what a task is. The reactive list of tasks and the logic that
 * mutates it live in `TaskController`.
 */
class Task {
  /**
   * Creates a task with the given [title].
   *
   * [completed] defaults to `false`. A unique [id] is generated from the
   * current timestamp combined with an internal sequence counter.
   */
  Task({
    required this.title,
    this.completed = false,
  }) : id = '${DateTime.now().microsecondsSinceEpoch}-${_seq++}';

  /**
   * Shared sequence counter used to keep the generated [id] unique even when
   * several tasks are created within the same microsecond.
   */
  static int _seq = 0;

  /**
   * Unique identifier of the task.
   *
   * Used to locate the task inside the list when toggling or deleting it. It is
   * `final` and never changes once the task is created.
   */
  final String id;

  /**
   * Human-readable text that describes the task (for example, "Study GetX").
   */
  String title;

  /**
   * Completion state of the task: `false` means pending, `true` means done.
   */
  bool completed;

  /**
   * Returns a debug-friendly string representation of the task.
   */
  @override
  String toString() => 'Task($id, "$title", completed: $completed)';
}
