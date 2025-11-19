// 📦 Importaciones
import 'package:flutter/foundation.dart'; // ChangeNotifier para estado reactivo
import '../models/todo_item.dart';
import '../services/storage_service.dart';

/// 📝 Provider de gestión de estado para la lista TODO
/// 
/// Implementa el patrón Provider de Flutter para gestionar:
/// - Lista actual de ítems TODO (preparación para la piscina)
/// - Operaciones CRUD (Create, Read, Update, Delete)
/// - Reordenamiento drag & drop
/// - Función chincheta (guardar/cargar lista base)
/// - Notificación a widgets cuando hay cambios
/// 
/// Extiende ChangeNotifier para notificación reactiva:
/// - Cuando cambia _todos, llama a notifyListeners()
/// - Los widgets Consumer<TodoProvider> se reconstruyen automáticamente
class TodoProvider extends ChangeNotifier {
  // 💾 Referencia al servicio de almacenamiento (Hive)
  final StorageService _storage;
  
  // 📋 Lista interna de TODOs (estado privado)
  List<TodoItem> _todos = [];

  /// 🏗️ Constructor del provider
  /// 
  /// [_storage]: Servicio de persistencia inyectado
  /// Carga automáticamente los TODOs al instanciar
  TodoProvider(this._storage) {
    _loadTodos();
  }

  // ==========================================
  // 📖 GETTERS PÚBLICOS
  // ==========================================

  /// 📋 Lista de TODOs expuesta públicamente (solo lectura)
  List<TodoItem> get todos => _todos;

  /// 📌 Verifica si existe una lista base guardada (chincheta)
  /// Usado para cambiar color del ícono de chincheta en UI
  bool get hasBaseList => _storage.hasBaseList();

  // ==========================================
  // 🔄 CARGA INICIAL
  // ==========================================

  /// 🔄 Carga TODOs desde el almacenamiento
  /// 
  /// Lógica de carga inteligente:
  /// 1. Si existe lista base Y lista actual está vacía → carga lista base
  /// 2. Si no, carga lo que haya en la lista actual
  /// 
  /// Se ejecuta automáticamente al crear el provider
  Future<void> _loadTodos() async {
    // Carga automática de lista base si está vacía
    if (_storage.hasBaseList() && _storage.getTodos().isEmpty) {
      await _storage.loadBaseListToTodos();
    }
    _todos = _storage.getTodos();
    notifyListeners(); // Notifica a los widgets listeners
  }

  // ==========================================
  // ➕ OPERACIONES CRUD
  // ==========================================

  /// ➕ Añade un nuevo ítem TODO
  /// 
  /// [text]: Descripción del ítem (ej: "Gafas de natación")
  /// Valida que no esté vacío (trim elimina espacios)
  Future<void> addTodo(String text) async {
    if (text.trim().isEmpty) return; // Validación: no permitir texto vacío
    
    final todo = TodoItem(text: text.trim());
    await _storage.addTodo(todo);
    _todos = _storage.getTodos(); // Refresca lista desde storage
    notifyListeners(); // Notifica cambio a UI
  }

  /// ✅ Marca/desmarca un TODO como completado (toggle)
  /// 
  /// [index]: Posición del ítem en la lista
  /// Invierte el estado isCompleted (true ↔ false)
  Future<void> toggleTodo(int index) async {
    if (index < 0 || index >= _todos.length) return; // Validación de rango
    
    _todos[index].isCompleted = !_todos[index].isCompleted; // Toggle
    await _storage.updateTodo(index, _todos[index]);
    notifyListeners(); // Actualiza UI (checkbox animado)
  }

  /// 🗑️ Elimina un ítem TODO
  /// 
  /// [index]: Posición del ítem en la lista
  /// Elimina permanentemente de Hive
  Future<void> deleteTodo(int index) async {
    if (index < 0 || index >= _todos.length) return; // Validación de rango
    
    await _storage.deleteTodo(index);
    _todos = _storage.getTodos(); // Refresca lista
    notifyListeners(); // Actualiza UI (animación de eliminación)
  }

  // ==========================================
  // 🔄 OPERACIONES MASIVAS
  // ==========================================

  /// ✅ Marca todos los ítems como completados
  /// 
  /// Usado desde el menú de opciones (PopupMenuButton)
  /// Útil cuando ya tienes todo preparado
  Future<void> markAll() async {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].isCompleted = true;
      await _storage.updateTodo(i, _todos[i]);
    }
    notifyListeners(); // Una sola notificación al final
  }

  /// ⬜ Desmarca todos los ítems (reinicia lista)
  /// 
  /// Usado desde el menú de opciones
  /// Útil para empezar de nuevo la preparación
  Future<void> unmarkAll() async {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].isCompleted = false;
      await _storage.updateTodo(i, _todos[i]);
    }
    notifyListeners(); // Una sola notificación al final
  }

  /// 🗑️ Elimina TODOS los ítems de la lista
  /// 
  /// ⚠️ Acción destructiva (sin confirmación en provider)
  /// La confirmación debe hacerse en la UI antes de llamar esto
  Future<void> deleteAll() async {
    await _storage.clearTodos();
    _todos = []; // Vacía lista local
    notifyListeners(); // UI muestra lista vacía
  }

  // ==========================================
  // 📌 FUNCIONALIDAD CHINCHETA (LISTA BASE)
  // ==========================================

  /// 📌 Guarda la lista actual como plantilla base
  /// 
  /// La "chincheta" permite al usuario definir su lista ideal
  /// de preparación que se cargará automáticamente al abrir la app.
  /// 
  /// Ejemplo: Si siempre llevas "Gafas, Gorro, Bañador",
  /// puedes guardar esa lista y no tener que recrearla cada vez.
  Future<void> pinCurrentList() async {
    await _storage.saveBaseList(_todos);
    notifyListeners(); // Actualiza ícono de chincheta (resaltado)
  }

  /// 🔄 Carga la lista base como lista actual
  /// 
  /// Restaura la plantilla guardada con chincheta.
  /// Todos los ítems se marcan como NO completados.
  Future<void> loadBaseList() async {
    await _storage.loadBaseListToTodos();
    _todos = _storage.getTodos();
    notifyListeners(); // Actualiza UI con nueva lista
  }

  // ==========================================
  // 🔀 REORDENAMIENTO Y EDICIÓN
  // ==========================================

  /// 🔀 Reordena ítems por drag & drop
  /// 
  /// [oldIndex]: Posición original del ítem arrastrado
  /// [newIndex]: Posición destino donde se suelta
  /// 
  /// Lógica de ReorderableListView:
  /// - Si arrastra hacia abajo: newIndex se ajusta -1
  /// - Guarda toda la lista reordenada en Hive
  Future<void> reorderTodos(int oldIndex, int newIndex) async {
    // Ajuste de índice para drag hacia abajo
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    // Reordena en memoria
    final item = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, item);
    
    // Persiste nuevo orden en Hive
    await _storage.saveTodos(_todos);
    notifyListeners(); // UI muestra nuevo orden
  }

  /// ✏️ Edita el texto de un ítem existente
  /// 
  /// [index]: Posición del ítem a editar
  /// [newText]: Nuevo texto descriptivo
  /// 
  /// Usado en edición inline (doble click sobre el ítem)
  Future<void> editTodo(int index, String newText) async {
    // Validaciones: índice válido y texto no vacío
    if (index < 0 || index >= _todos.length || newText.trim().isEmpty) return;
    
    _todos[index].text = newText.trim();
    await _storage.updateTodo(index, _todos[index]);
    notifyListeners(); // Actualiza UI con texto editado
  }
}
