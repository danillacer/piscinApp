import 'package:flutter/material.dart';
import '../models/todo_item.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem todo;
  final int index;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.index,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _finishEditing() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onEdit(_controller.text);
    } else {
      _controller.text = widget.todo.text;
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReorderableDragStartListener(
              index: widget.index,
              child: const Icon(
                Icons.drag_handle,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Checkbox(
              value: widget.todo.isCompleted,
              onChanged: _isEditing ? null : (_) => widget.onToggle(),
            ),
          ],
        ),
        title: _isEditing
            ? TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (_) => _finishEditing(),
              )
            : GestureDetector(
                onDoubleTap: _startEditing,
                child: Text(
                  widget.todo.text,
                  style: TextStyle(
                    decoration: widget.todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: widget.todo.isCompleted ? Colors.grey : null,
                  ),
                ),
              ),
        trailing: _isEditing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: _finishEditing,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      _controller.text = widget.todo.text;
                      setState(() {
                        _isEditing = false;
                      });
                    },
                  ),
                ],
              )
            : IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: widget.onDelete,
              ),
        onTap: _isEditing ? null : widget.onToggle,
      ),
    );
  }
}
