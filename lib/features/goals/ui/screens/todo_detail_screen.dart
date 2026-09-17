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
        title: const Text('Your next step'),
        titleSpacing: 8,
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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card Header
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF416F5E), Color(0xFF244C40)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF244C40).withValues(alpha: 0.26),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'YOUR COMMITMENT',
                            style: TextStyle(
                              color: Color(0xFFDDECE5),
                              fontSize: 10,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 26,
                            height: 1.12,
                            letterSpacing: -0.45,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        if (todo.dueTime != null) ...[
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.notifications_active_rounded, size: 16, color: Color(0xFFC9E5D7)),
                              const SizedBox(width: 6),
                              Text(
                                'Reminder at ${TimeOfDay.fromDateTime(todo.dueTime!).format(context)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFDDECE5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Subtasks header
                  const Text(
                    'Break it into steps',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF20332F),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    todo.subTodos.isEmpty
                        ? 'This task is ready whenever you are.'
                        : '${todo.subTodos.where((sub) => sub.isCompleted).length} of ${todo.subTodos.length} steps complete',
                    style: const TextStyle(color: Color(0xFF71827B), fontSize: 13),
                  ),
                  const SizedBox(height: 13),

                  // Subtasks lists
                  Expanded(
                    child: todo.subTodos.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.82),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFDFE8E2)),
                            ),
                            child: const Text(
                              'No smaller steps needed —\nthis one is beautifully clear.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF65706B), fontSize: 15, height: 1.45),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.88),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFDFE8E2)),
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              itemCount: todo.subTodos.length,
                              separatorBuilder: (_, __) => const Divider(height: 1, indent: 22, endIndent: 22),
                              itemBuilder: (context, index) {
                                final sub = todo.subTodos[index];
                                return CheckboxListTile(
                                  value: sub.isCompleted,
                                  activeColor: const Color(0xFF3E7965),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text(
                                    sub.title ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
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

                  const SizedBox(height: 28),

                  // Finish task button
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF315B4D).withValues(alpha: 0.22),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: FilledButton.icon(
                    onPressed: () async {
                      await ref.read(activeTodosProvider.notifier).toggleTodo(todo.id);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    icon: const Icon(Icons.check_circle_rounded),
                    label: const Text('Complete to-do'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF315F50),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
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
