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

class _TodoCreationScreenState extends ConsumerState<TodoCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subTaskController = TextEditingController();
  
  TimeOfDay? _selectedTime;
  final List<SubTodo> _subTasks = [];

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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

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
    }

    if (widget.todoId != null) {
      ref.read(activeTodosProvider.notifier).updateTodo(
        id: widget.todoId!,
        title: _titleController.text.trim(),
        dueTime: dueDateTime,
        subTodos: _subTasks,
      );
    } else {
      ref.read(activeTodosProvider.notifier).addTodo(
        _titleController.text.trim(),
        dueDateTime,
        _subTasks.map((s) => s.title ?? '').toList(),
      );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todoId != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: Text(isEditing ? 'Edit To-Do' : 'New To-Do'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEditing ? 'Modify your to-do details' : 'What would you like to accomplish?',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF20332F),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    hintText: 'e.g. Clean up the desk',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Due Time selector
                InkWell(
                  onTap: _selectTime,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_filled_rounded, color: Color(0xFF4D8C76)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Scheduled Time (Optional)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF65706B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedTime != null
                                    ? _selectedTime!.format(context)
                                    : 'Choose Time',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF20332F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_selectedTime != null)
                          IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              setState(() => _selectedTime = null);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sub-tasks Section
                const Text(
                  'Sub-tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF20332F),
                  ),
                ),
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _subTaskController,
                        decoration: InputDecoration(
                          hintText: 'Add a sub-task...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onFieldSubmitted: (_) => _addSubTask(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D8C76),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add_rounded, color: Colors.white),
                        onPressed: _addSubTask,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Subtasks List
                if (_subTasks.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _subTasks.length,
                      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
                      itemBuilder: (context, index) {
                        final sub = _subTasks[index];
                        return ListTile(
                          leading: Icon(
                            sub.isCompleted ? Icons.check_circle_outline_rounded : Icons.subdirectory_arrow_right_rounded,
                            size: 18,
                            color: sub.isCompleted ? const Color(0xFF4D8C76) : const Color(0xFF65706B),
                          ),
                          title: Text(
                            sub.title ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xFF20332F),
                              fontWeight: FontWeight.w600,
                              decoration: sub.isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                            onPressed: () => _removeSubTask(index),
                          ),
                        );
                      },
                    ),
                  ),
                
                const SizedBox(height: 40),

                // Submit Button
                FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF4D8C76),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Save Changes' : 'Save To-Do',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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
