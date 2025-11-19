/// 📝 Widget de Ítem TODO con edición inline
///
/// Funcionalidades:
/// - ↕️ Drag handle para reordenar con ReorderableListView
/// - ✔️ Checkbox para marcar/desmarcar como completado
/// - 👆 Doble clic en el texto para entrar en modo edición
/// - ✏️ Modo edición: TextField con botones de confirmar/cancelar
/// - 🗑️ Botón de eliminar (rojo)
/// - 👁️ Tachado automático para ítems completados
///
/// El widget es Stateful para manejar el estado de edición localmente.
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

  // ✏️ Activar modo edición (se activa con doble clic)
  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  // ✔️ Finalizar edición y guardar cambios
  // Si el texto está vacío, restaura el valor original
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
        // ↕️ Leading: Drag handle + Checkbox
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle para arrastrar y reordenar
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
        // 📝 Título: TextField en modo edición, Text con doble clic en modo normal
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
        // ⚙️ Trailing: Botones de confirmar/cancelar en edición, botón de eliminar en normal
        trailing: _isEditing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✔️ Confirmar edición
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: _finishEditing,
                  ),
                  // ❌ Cancelar edición
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
