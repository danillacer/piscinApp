import 'package:flutter/foundation.dart';
import '../models/swimming_session.dart';
import '../services/storage_service.dart';

class SessionProvider extends ChangeNotifier {
  final StorageService _storage;
  List<SwimmingSession> _sessions = [];

  SessionProvider(this._storage) {
    _loadSessions();
  }

  List<SwimmingSession> get sessions => _sessions;

  int get totalPools => _sessions.fold(0, (sum, session) => sum + session.pools);
  
  int get totalMeters => _sessions.fold(0, (sum, session) => sum + session.meters);

  Future<void> _loadSessions() async {
    _sessions = _storage.getSessions();
    notifyListeners();
  }

  Future<void> addSession(int pools, DateTime date) async {
    if (pools <= 0) return;
    
    final session = SwimmingSession(pools: pools, date: date);
    await _storage.addSession(session);
    _sessions = _storage.getSessions();
    
    // Actualizar racha
    final settings = _storage.getSettings();
    settings.updateStreak(date);
    await _storage.saveSettings(settings);
    
    notifyListeners();
  }

  int getCurrentStreak() {
    return _storage.getSettings().currentStreak;
  }

  int getBestStreak() {
    return _storage.getSettings().bestStreak;
  }

  int getWeeklyGoal() {
    return _storage.getSettings().weeklyGoal;
  }

  int getWeeklyProgress() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekSessions = _sessions.where((session) {
      return session.date.isAfter(startOfWeek.subtract(const Duration(days: 1)));
    });
    return weekSessions.fold(0, (sum, session) => sum + session.pools);
  }

  Future<void> setWeeklyGoal(int goal) async {
    final settings = _storage.getSettings();
    settings.weeklyGoal = goal;
    await _storage.saveSettings(settings);
    notifyListeners();
  }

  Future<void> deleteSession(int index) async {
    if (index < 0 || index >= _sessions.length) return;
    
    await _storage.deleteSession(index);
    _sessions = _storage.getSessions();
    notifyListeners();
  }

  Future<void> clearAllSessions() async {
    await _storage.clearSessions();
    _sessions = [];
    notifyListeners();
  }
}
