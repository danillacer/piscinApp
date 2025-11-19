import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo_item.dart';
import '../models/swimming_session.dart';
import '../models/user_settings.dart';

class StorageService {
  static const String _todoBoxName = 'todos';
  static const String _baseListBoxName = 'baseList';
  static const String _sessionsBoxName = 'sessions';
  static const String _settingsBoxName = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoItemAdapter());
    Hive.registerAdapter(SwimmingSessionAdapter());
    Hive.registerAdapter(UserSettingsAdapter());
    
    await Hive.openBox<TodoItem>(_todoBoxName);
    await Hive.openBox<TodoItem>(_baseListBoxName);
    await Hive.openBox<SwimmingSession>(_sessionsBoxName);
    await Hive.openBox<UserSettings>(_settingsBoxName);
  }

  // Todo Items
  Box<TodoItem> get todosBox => Hive.box<TodoItem>(_todoBoxName);
  
  Future<void> saveTodos(List<TodoItem> todos) async {
    await todosBox.clear();
    await todosBox.addAll(todos);
  }

  List<TodoItem> getTodos() {
    return todosBox.values.toList();
  }

  Future<void> addTodo(TodoItem todo) async {
    await todosBox.add(todo);
  }

  Future<void> deleteTodo(int index) async {
    await todosBox.deleteAt(index);
  }

  Future<void> updateTodo(int index, TodoItem todo) async {
    await todosBox.putAt(index, todo);
  }

  Future<void> clearTodos() async {
    await todosBox.clear();
  }

  // Base List (Chincheta)
  Box<TodoItem> get baseListBox => Hive.box<TodoItem>(_baseListBoxName);
  
  Future<void> saveBaseList(List<TodoItem> items) async {
    await baseListBox.clear();
    // Crear copias nuevas de los ítems para evitar conflictos de keys en Hive
    final newItems = items.map((item) => TodoItem(
      text: item.text,
      isCompleted: item.isCompleted,
    )).toList();
    await baseListBox.addAll(newItems);
  }

  List<TodoItem> getBaseList() {
    return baseListBox.values.toList();
  }

  bool hasBaseList() {
    return baseListBox.isNotEmpty;
  }

  Future<void> loadBaseListToTodos() async {
    final baseList = getBaseList();
    if (baseList.isNotEmpty) {
      final uncompletedList = baseList.map((item) {
        return TodoItem(text: item.text, isCompleted: false);
      }).toList();
      await saveTodos(uncompletedList);
    }
  }

  // Swimming Sessions
  Box<SwimmingSession> get sessionsBox => Hive.box<SwimmingSession>(_sessionsBoxName);
  
  Future<void> addSession(SwimmingSession session) async {
    await sessionsBox.add(session);
  }

  List<SwimmingSession> getSessions() {
    final sessions = sessionsBox.values.toList();
    sessions.sort((a, b) => a.date.compareTo(b.date));
    return sessions;
  }

  Future<void> deleteSession(int index) async {
    await sessionsBox.deleteAt(index);
  }

  Future<void> clearSessions() async {
    await sessionsBox.clear();
  }

  // User Settings
  Box<UserSettings> get settingsBox => Hive.box<UserSettings>(_settingsBoxName);
  
  UserSettings getSettings() {
    if (settingsBox.isEmpty) {
      final settings = UserSettings();
      settingsBox.add(settings);
      return settings;
    }
    return settingsBox.getAt(0)!;
  }

  Future<void> saveSettings(UserSettings settings) async {
    if (settingsBox.isEmpty) {
      await settingsBox.add(settings);
    } else {
      await settingsBox.putAt(0, settings);
    }
  }
}
