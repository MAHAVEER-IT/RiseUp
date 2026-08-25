import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/todo_provider.dart';
import '../../models/todo.dart';

class TodoDetailScreen extends ConsumerWidget {
  const TodoDetailScreen({Key? key, required this.todoId}) : super(key: key);

  final int todoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(activeTodosProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Text('To-Do Detail'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: Color(0xFF4D8C76)),
            tooltip: 'Edit To-Do',
            onPressed: () {
              context.push('/todo-creation?todoId=$todoId');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete To-Do'),
                  content: const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(activeTodosProvider.notifier).deleteTodo(todoId);
                if (context.mounted) {
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: todosState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (todos) {
            final todoIndex = todos.indexWhere((t) => t.id == todoId);
            if (todoIndex == -1) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Task Completed or Not Found!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF20332F)),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            final todo = todos[todoIndex];

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF315044).withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF20332F),
                          ),
                        ),
                        if (todo.dueTime != null) ...[
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF4D8C76)),
                              const SizedBox(width: 6),
                              Text(
                                'Scheduled at ${TimeOfDay.fromDateTime(todo.dueTime!).format(context)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4D8C76),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Subtasks header
                  const Text(
                    'Sub-tasks Progress',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF20332F),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtasks lists
                  Expanded(
                    child: todo.subTodos.isEmpty
                        ? const Center(
                            child: Text(
                              'No sub-tasks added.',
                              style: TextStyle(color: Color(0xFF65706B), fontSize: 15),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: todo.subTodos.length,
                              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
                              itemBuilder: (context, index) {
                                final sub = todo.subTodos[index];
                                return CheckboxListTile(
                                  value: sub.isCompleted,
                                  activeColor: const Color(0xFF4D8C76),
                                  title: Text(
                                    sub.title ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: sub.isCompleted ? const Color(0xFF8A9590) : const Color(0xFF20332F),
                                      decoration: sub.isCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  onChanged: (_) {
                                    ref.read(activeTodosProvider.notifier).toggleSubTodo(todo.id, index);
                                  },
                                );
                              },
                            ),
                          ),
                  ),

                  const SizedBox(height: 24),

                  // Finish task button
                  FilledButton.icon(
                    onPressed: () async {
                      await ref.read(activeTodosProvider.notifier).toggleTodo(todo.id);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    icon: const Icon(Icons.check_circle_outline_rounded),
                    label: const Text('Complete To-Do'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4D8C76),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
