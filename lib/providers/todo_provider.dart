import 'package:flutter/foundation.dart';
import '../models/todo_item.dart';
import '../services/storage_service.dart';

class TodoProvider extends ChangeNotifier {
  final StorageService _storage;
  List<TodoItem> _todos = [];

  TodoProvider(this._storage) {
    _loadTodos();
  }

  List<TodoItem> get todos => _todos;

  bool get hasBaseList => _storage.hasBaseList();

  Future<void> _loadTodos() async {
    if (_storage.hasBaseList() && _storage.getTodos().isEmpty) {
      await _storage.loadBaseListToTodos();
    }
    _todos = _storage.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(String text) async {
    if (text.trim().isEmpty) return;
    
    final todo = TodoItem(text: text.trim());
    await _storage.addTodo(todo);
    _todos = _storage.getTodos();
    notifyListeners();
  }

  Future<void> toggleTodo(int index) async {
    if (index < 0 || index >= _todos.length) return;
    
    _todos[index].isCompleted = !_todos[index].isCompleted;
    await _storage.updateTodo(index, _todos[index]);
    notifyListeners();
  }

  Future<void> deleteTodo(int index) async {
    if (index < 0 || index >= _todos.length) return;
    
    await _storage.deleteTodo(index);
    _todos = _storage.getTodos();
    notifyListeners();
  }

  Future<void> markAll() async {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].isCompleted = true;
      await _storage.updateTodo(i, _todos[i]);
    }
    notifyListeners();
  }

  Future<void> unmarkAll() async {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i].isCompleted = false;
      await _storage.updateTodo(i, _todos[i]);
    }
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await _storage.clearTodos();
    _todos = [];
    notifyListeners();
  }

  Future<void> pinCurrentList() async {
    await _storage.saveBaseList(_todos);
    notifyListeners();
  }

  Future<void> loadBaseList() async {
    await _storage.loadBaseListToTodos();
    _todos = _storage.getTodos();
    notifyListeners();
  }

  Future<void> reorderTodos(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, item);
    await _storage.saveTodos(_todos);
    notifyListeners();
  }

  Future<void> editTodo(int index, String newText) async {
    if (index < 0 || index >= _todos.length || newText.trim().isEmpty) return;
    
    _todos[index].text = newText.trim();
    await _storage.updateTodo(index, _todos[index]);
    notifyListeners();
  }
}
