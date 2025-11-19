// 📦 Importaciones
import 'package:hive_flutter/hive_flutter.dart'; // Base de datos NoSQL local
import '../models/todo_item.dart';
import '../models/swimming_session.dart';
import '../models/user_settings.dart';

/// 💾 Servicio de almacenamiento local con Hive (NoSQL)
/// 
/// Gestiona la persistencia de todos los datos de la app:
/// - Lista TODO actual (ítems de preparación)
/// - Lista base guardada con chincheta (plantilla)
/// - Sesiones de natación históricas
/// - Configuración y preferencias del usuario
/// 
/// Hive es una base de datos NoSQL rápida, ligera y optimizada para Flutter.
/// Los datos se almacenan en el dispositivo y persisten entre sesiones.
class StorageService {
  // 📦 Nombres de las "cajas" (boxes) de Hive - equivalentes a tablas
  static const String _todoBoxName = 'todos'; // Lista TODO actual
  static const String _baseListBoxName = 'baseList'; // Lista base (chincheta)
  static const String _sessionsBoxName = 'sessions'; // Sesiones de natación
  static const String _settingsBoxName = 'settings'; // Configuración usuario

  /// 🚀 Inicializa Hive y abre todas las cajas de datos
  /// 
  /// Debe ejecutarse antes de usar la app (en main.dart).
  /// Realiza 3 pasos críticos:
  /// 1. Inicializa Hive para Flutter (configura rutas de almacenamiento)
  /// 2. Registra adapters TypeAdapters generados automáticamente)
  /// 3. Abre todas las cajas necesarias para la app
  /// 
  /// Los adapters permiten que Hive sepa cómo serializar/deserializar
  /// los objetos custom (TodoItem, SwimmingSession, UserSettings).
  static Future<void> init() async {
    // Inicializa Hive con rutas optimizadas para Flutter
    await Hive.initFlutter();
    
    // Registra los adapters de Hive para los modelos custom
    // Estos archivos son generados por build_runner
    Hive.registerAdapter(TodoItemAdapter()); // TypeId: 0
    Hive.registerAdapter(SwimmingSessionAdapter()); // TypeId: 1
    Hive.registerAdapter(UserSettingsAdapter()); // TypeId: 2
    
    // Abre las 4 cajas de datos de la app
    // Si no existen, se crean automáticamente
    await Hive.openBox<TodoItem>(_todoBoxName);
    await Hive.openBox<TodoItem>(_baseListBoxName);
    await Hive.openBox<SwimmingSession>(_sessionsBoxName);
    await Hive.openBox<UserSettings>(_settingsBoxName);
  }

  // ==========================================
  // 📝 OPERACIONES DE LISTA TODO
  // ==========================================
  
  /// 📦 Acceso directo a la caja de TODOs actuales
  Box<TodoItem> get todosBox => Hive.box<TodoItem>(_todoBoxName);
  
  /// 💾 Guarda lista completa de TODOs (reemplaza existente)
  /// Usado principalmente para reordenamiento drag & drop
  Future<void> saveTodos(List<TodoItem> todos) async {
    await todosBox.clear(); // Elimina todos los ítems existentes
    await todosBox.addAll(todos); // Añade la nueva lista ordenada
  }

  /// 📋 Obtiene lista completa de TODOs
  /// Retorna lista vacía si no hay ítems
  List<TodoItem> getTodos() {
    return todosBox.values.toList();
  }

  /// ➕ Añade un nuevo ítem TODO al final de la lista
  Future<void> addTodo(TodoItem todo) async {
    await todosBox.add(todo);
  }

  /// 🗑️ Elimina un ítem TODO por su índice
  Future<void> deleteTodo(int index) async {
    await todosBox.deleteAt(index);
  }

  /// ✏️ Actualiza un ítem TODO existente
  /// Usado para edición inline (doble click)
  Future<void> updateTodo(int index, TodoItem todo) async {
    await todosBox.putAt(index, todo);
  }

  /// 🧹 Elimina todos los ítems TODO
  /// Usado en la acción "Borrar todos" del menú
  Future<void> clearTodos() async {
    await todosBox.clear();
  }

  // ==========================================
  // 📌 OPERACIONES DE LISTA BASE (CHINCHETA)
  // ==========================================
  
  /// 📦 Acceso directo a la caja de lista base (plantilla)
  Box<TodoItem> get baseListBox => Hive.box<TodoItem>(_baseListBoxName);
  
  /// 📌 Guarda lista actual como plantilla base
  /// 
  /// La función "chincheta" permite al usuario guardar su lista
  /// de preparación ideal que se cargará automáticamente al abrir la app.
  /// 
  /// IMPORTANTE: Crea copias nuevas de los ítems para evitar conflictos
  /// de keys en Hive (un objeto no puede estar en dos cajas a la vez).
  Future<void> saveBaseList(List<TodoItem> items) async {
    await baseListBox.clear(); // Elimina plantilla anterior
    
    // Crear copias nuevas para evitar conflicto de keys de Hive
    // Si usáramos los ítems originales, Hive daría error porque
    // ya existen en la caja 'todos'
    final newItems = items.map((item) => TodoItem(
      text: item.text,
      isCompleted: item.isCompleted,
    )).toList();
    
    await baseListBox.addAll(newItems);
  }

  /// 📋 Obtiene lista base guardada (plantilla)
  List<TodoItem> getBaseList() {
    return baseListBox.values.toList();
  }

  /// ❓ Verifica si existe una lista base guardada
  /// Usado para mostrar el ícono de chincheta resaltado
  bool hasBaseList() {
    return baseListBox.isNotEmpty;
  }

  /// 🔄 Carga lista base como lista TODO actual
  /// 
  /// Se ejecuta automáticamente al iniciar la app (TodoProvider).
  /// Todos los ítems se marcan como NO completados (isCompleted: false)
  /// para que el usuario pueda marcarlos de nuevo.
  Future<void> loadBaseListToTodos() async {
    final baseList = getBaseList();
    if (baseList.isNotEmpty) {
      // Crear nueva lista con todos los ítems desmarcados
      final uncompletedList = baseList.map((item) {
        return TodoItem(text: item.text, isCompleted: false);
      }).toList();
      await saveTodos(uncompletedList); // Reemplaza lista TODO actual
    }
  }

  // ==========================================
  // 🏊 OPERACIONES DE SESIONES DE NATACIÓN
  // ==========================================
  
  /// 📦 Acceso directo a la caja de sesiones
  Box<SwimmingSession> get sessionsBox => Hive.box<SwimmingSession>(_sessionsBoxName);
  
  /// ➕ Añade una nueva sesión de natación
  Future<void> addSession(SwimmingSession session) async {
    await sessionsBox.add(session);
  }

  /// 📋 Obtiene todas las sesiones ordenadas por fecha (ascendente)
  /// 
  /// Las sesiones se devuelven ordenadas cronológicamente:
  /// más antiguas primero, más recientes al final.
  /// Útil para mostrar historial y generar gráficas.
  List<SwimmingSession> getSessions() {
    final sessions = sessionsBox.values.toList();
    sessions.sort((a, b) => a.date.compareTo(b.date)); // Orden: antigua → reciente
    return sessions;
  }

  /// 🗑️ Elimina una sesión por su índice
  Future<void> deleteSession(int index) async {
    await sessionsBox.deleteAt(index);
  }

  /// 🧹 Elimina todas las sesiones
  /// Usar con precaución (sin confirmación doble)
  Future<void> clearSessions() async {
    await sessionsBox.clear();
  }

  // ==========================================
  // ⚙️ OPERACIONES DE CONFIGURACIÓN DE USUARIO
  // ==========================================
  
  /// 📦 Acceso directo a la caja de configuración
  /// Solo existe un objeto UserSettings por usuario (índice 0)
  Box<UserSettings> get settingsBox => Hive.box<UserSettings>(_settingsBoxName);
  
  /// 📖 Obtiene configuración del usuario
  /// 
  /// Si no existe configuración (primera vez), crea una nueva
  /// con valores por defecto (weeklyGoal: 100, streaks: 0, etc.)
  /// y la guarda automáticamente.
  UserSettings getSettings() {
    if (settingsBox.isEmpty) {
      // Primera vez: crear configuración por defecto
      final settings = UserSettings();
      settingsBox.add(settings);
      return settings;
    }
    // Retorna configuración existente (siempre en índice 0)
    return settingsBox.getAt(0)!;
  }

  /// 💾 Guarda configuración del usuario
  /// 
  /// Actualiza objetivo semanal, rachas, preferencias de tema, etc.
  /// Si es la primera vez, añade la configuración.
  /// Si ya existe, actualiza el objeto en índice 0.
  Future<void> saveSettings(UserSettings settings) async {
    if (settingsBox.isEmpty) {
      await settingsBox.add(settings); // Primera vez: añadir
    } else {
      await settingsBox.putAt(0, settings); // Ya existe: actualizar
    }
  }
}
