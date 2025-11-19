/// ✅ Página de Lista TODO (Preparar la piscina)
///
/// Funcionalidades:
/// - ➕ Añadir nuevos ítems con TextField + botón
/// - ↕️ Reordenar ítems con drag & drop (ReorderableListView)
/// - ✔️ Marcar/desmarcar ítems como completados
/// - ✏️ Editar ítems con doble clic
/// - 🗑️ Eliminar ítems individuales
/// - 📌 Chincheta: Guardar lista actual como "lista base" para restaurarla
/// - ⚙️ Menú de opciones: marcar todos, desmarcar todos, borrar todos
///
/// La lista se guarda automáticamente en Hive al hacer cambios.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ➕ Añadir nuevo ítem TODO
  // Valida que el texto no esté vacío antes de añadir
  void _addTodo() {
    if (_controller.text.trim().isNotEmpty) {
      context.read<TodoProvider>().addTodo(_controller.text);
      _controller.clear();
    }
  }

  // 📌 Mostrar diálogo de confirmación para guardar lista base
  // La "lista base" es la plantilla que se carga al iniciar la app
  void _showPinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Guardar lista base'),
        content: const Text(
          '¿Deseas guardar esta lista como tu lista base? '
          'Esta lista aparecerá cada vez que abras la app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<TodoProvider>().pinCurrentList();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lista base guardada'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparar la piscina'),
        actions: [
          // 📌 Botón de chincheta (se resalta si ya hay lista base guardada)
          IconButton(
            icon: Icon(
              Icons.push_pin,
              color: context.watch<TodoProvider>().hasBaseList
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            tooltip: 'Guardar como lista base',
            onPressed: _showPinDialog,
          ),
          // ⚙️ Menú de opciones masivas
          PopupMenuButton<String>(
            onSelected: (value) async {
              final provider = context.read<TodoProvider>();
              switch (value) {
                case 'mark_all':
                  await provider.markAll();
                  break;
                case 'unmark_all':
                  await provider.unmarkAll();
                  break;
                case 'delete_all':
                  await provider.deleteAll();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all',
                child: Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(width: 8),
                    Text('Marcar todos'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'unmark_all',
                child: Row(
                  children: [
                    Icon(Icons.check_box_outline_blank),
                    SizedBox(width: 8),
                    Text('Desmarcar todos'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep),
                    SizedBox(width: 8),
                    Text('Borrar todos'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // ✏️ Campo de entrada para nuevos ítems
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nuevo ítem',
                      hintText: 'Ej: Gafas, gorro, bañador...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _addTodo,
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, provider, child) {
                // 📦 Estado vacío: mostrar mensaje cuando no hay ítems
                if (provider.todos.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_add_check,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No hay ítems en la lista',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ↕️ Lista reordenable con drag & drop
                // Cada ítem tiene un handle para arrastrar y reordenar
                return ReorderableListView.builder(
                  itemCount: provider.todos.length,
                  onReorder: (oldIndex, newIndex) {
                    provider.reorderTodos(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final todo = provider.todos[index];
                    return TodoItemWidget(
                      key: ValueKey(todo.text + index.toString()),
                      todo: todo,
                      index: index,
                      onToggle: () => provider.toggleTodo(index),
                      onDelete: () => provider.deleteTodo(index),
                      onEdit: (newText) => provider.editTodo(index, newText),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
