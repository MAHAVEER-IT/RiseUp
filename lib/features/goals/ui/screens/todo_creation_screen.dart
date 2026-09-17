import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/todo_provider.dart';
import '../../models/todo.dart';

class TodoCreationScreen extends ConsumerStatefulWidget {
  const TodoCreationScreen({Key? key, this.todoId}) : super(key: key);

  final int? todoId;

  @override
  ConsumerState<TodoCreationScreen> createState() => _TodoCreationScreenState();
}

class _FormSectionLabel extends StatelessWidget {
  const _FormSectionLabel({
    required this.number,
    required this.title,
    this.subtitle,
  });

  final String number;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 27,
          height: 27,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF4D8C76).withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFF39745F),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF20332F),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Color(0xFF71827B),
                      fontSize: 12,
                      height: 1.25,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormSurface extends StatelessWidget {
  const _FormSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDFE8E2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF315B4D).withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _TodoCreationScreenState extends ConsumerState<TodoCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subTaskController = TextEditingController();

  TimeOfDay? _selectedTime;
  final List<SubTodo> _subTasks = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.todoId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final todos = ref.read(activeTodosProvider).value ?? [];
        final todoIndex = todos.indexWhere((t) => t.id == widget.todoId);
        if (todoIndex != -1) {
          final todo = todos[todoIndex];
          setState(() {
            _titleController.text = todo.title;
            if (todo.dueTime != null) {
              _selectedTime = TimeOfDay.fromDateTime(todo.dueTime!);
            }
            _subTasks.addAll(todo.subTodos);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTaskController.dispose();
    super.dispose();
  }

  void _addSubTask() {
    final text = _subTaskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _subTasks.add(SubTodo(title: text, isCompleted: false));
        _subTaskController.clear();
      });
    }
  }

  void _removeSubTask(int index) {
    setState(() {
      _subTasks.removeAt(index);
    });
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4D8C76),
              onPrimary: Colors.white,
              onSurface: Color(0xFF20332F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSaving) return;
    setState(() => _isSaving = true);

    DateTime? dueDateTime;
    if (_selectedTime != null) {
      final now = DateTime.now();
      dueDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      // The picker contains a time, not a date. A time already passed today
      // should mean the next occurrence, rather than silently skipping the
      // reminder as an expired alarm.
      if (!dueDateTime.isAfter(now)) {
        dueDateTime = dueDateTime.add(const Duration(days: 1));
      }
    }

    if (widget.todoId != null) {
      await ref.read(activeTodosProvider.notifier).updateTodo(
        id: widget.todoId!,
        title: _titleController.text.trim(),
        dueTime: dueDateTime,
        subTodos: _subTasks,
      );
    } else {
      await ref.read(activeTodosProvider.notifier).addTodo(
        _titleController.text.trim(),
        dueDateTime,
        _subTasks.map((s) => s.title ?? '').toList(),
      );
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todoId != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: Text(isEditing ? 'Edit To-Do' : 'New To-Do'),
        titleSpacing: 8,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEditing
                      ? 'Refine the next step that matters.'
                      : 'Make one clear promise to yourself.',
                  style: const TextStyle(
                    fontSize: 25,
                    height: 1.14,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF20332F),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Small, specific actions are easier to begin.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.45),
                ),
                const SizedBox(height: 26),

                // 1. Task
                const _FormSectionLabel(number: '01', title: 'Your task'),
                const SizedBox(height: 10),
                _FormSurface(
                  child: TextFormField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF20332F),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'e.g. Clean up the desk',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                      border: InputBorder.none,
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter a task title'
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Sub-tasks
                const _FormSectionLabel(
                  number: '02',
                  title: 'Sub-tasks',
                  subtitle: 'Optional — break the first step down.',
                ),
                const SizedBox(height: 10),
                _FormSurface(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _subTaskController,
                              decoration: const InputDecoration(
                                hintText: 'Add a small step',
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (_) => _addSubTask(),
                            ),
                          ),
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFF4D8C76),
                            ),
                            icon: const Icon(Icons.add_rounded),
                            onPressed: _addSubTask,
                          ),
                        ],
                      ),
                      if (_subTasks.isNotEmpty) ...[
                        const Divider(height: 26),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _subTasks.length,
                          separatorBuilder: (_, __) => const Divider(height: 14),
                          itemBuilder: (context, index) {
                            final sub = _subTasks[index];
                            return Row(
                              children: [
                                const Icon(Icons.arrow_right_rounded, color: Color(0xFF6E9486)),
                                Expanded(
                                  child: Text(
                                    sub.title ?? '',
                                    style: const TextStyle(
                                      color: Color(0xFF20332F),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Remove sub-task',
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.close_rounded, size: 18),
                                  color: const Color(0xFF9A6B63),
                                  onPressed: () => _removeSubTask(index),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Reminder
                const _FormSectionLabel(
                  number: '03',
                  title: 'Reminder time',
                  subtitle: 'Optional — a gentle nudge when it matters.',
                ),
                const SizedBox(height: 10),
                _FormSurface(
                  child: InkWell(
                    onTap: _selectTime,
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4D8C76).withValues(alpha: 0.13),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Icon(Icons.notifications_active_rounded, color: Color(0xFF3E7965)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedTime?.format(context) ?? 'Choose a time',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF20332F),
                              ),
                            ),
                          ),
                          if (_selectedTime != null)
                            IconButton(
                              tooltip: 'Clear reminder',
                              icon: const Icon(Icons.close_rounded, size: 18),
                              onPressed: () => setState(() => _selectedTime = null),
                            )
                          else
                            const Icon(Icons.chevron_right_rounded, color: Color(0xFF7D928A)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // 4. Save
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF315B4D).withValues(alpha: 0.23),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _submit,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: _isSaving
                          ? const SizedBox(
                              key: ValueKey('saving'),
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.check_circle_rounded,
                              key: ValueKey('ready'),
                            ),
                    ),
                    label: Text(
                      _isSaving
                          ? 'Saving your step...'
                          : isEditing
                          ? 'Save changes'
                          : 'Create to-do',
                    ),
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
          ),
        ),
      ),
    );
  }
}
