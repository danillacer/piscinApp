// 📦 Importaciones
import 'package:flutter/foundation.dart'; // ChangeNotifier para estado reactivo
import '../models/swimming_session.dart';
import '../services/storage_service.dart';

/// 🏊 Provider de gestión de estado para sesiones de natación
/// 
/// Implementa el patrón Provider de Flutter para gestionar:
/// - Historial de sesiones de natación (piscinas, metros, fechas)
/// - Cálculos de totales y estadísticas
/// - Sistema de rachas (días consecutivos nadando)
/// - Objetivos semanales personalizables
/// - Notificación a widgets cuando hay cambios
/// 
/// Extiende ChangeNotifier para notificación reactiva:
/// - Cuando cambia _sessions, llama a notifyListeners()
/// - Los widgets Consumer<SessionProvider> se reconstruyen automáticamente
class SessionProvider extends ChangeNotifier {
  // 💾 Referencia al servicio de almacenamiento (Hive)
  final StorageService _storage;
  
  // 🏊 Lista interna de sesiones (estado privado)
  List<SwimmingSession> _sessions = [];

  /// 🏗️ Constructor del provider
  /// 
  /// [_storage]: Servicio de persistencia inyectado
  /// Carga automáticamente las sesiones al instanciar
  SessionProvider(this._storage) {
    _loadSessions();
  }

  // ==========================================
  // 📖 GETTERS PÚBLICOS
  // ==========================================

  /// 🏊 Lista de sesiones expuesta públicamente (solo lectura)
  List<SwimmingSession> get sessions => _sessions;

  /// 🔢 Total de piscinas nadadas en todas las sesiones
  /// 
  /// Usa fold para sumar pools de todas las sesiones
  /// Ejemplo: [40, 30, 50] → 120 piscinas totales
  int get totalPools => _sessions.fold(0, (sum, session) => sum + session.pools);
  
  /// 📏 Total de metros nadados en todas las sesiones
  /// 
  /// Usa fold para sumar metros de todas las sesiones
  /// Ejemplo: [1000, 750, 1250] → 3000 metros totales
  int get totalMeters => _sessions.fold(0, (sum, session) => sum + session.meters);

  // ==========================================
  // 🔄 CARGA INICIAL
  // ==========================================

  /// 🔄 Carga sesiones desde el almacenamiento
  /// 
  /// Las sesiones vienen ordenadas por fecha (más antiguas primero)
  /// Se ejecuta automáticamente al crear el provider
  Future<void> _loadSessions() async {
    _sessions = _storage.getSessions(); // Ya vienen ordenadas de StorageService
    notifyListeners(); // Notifica a los widgets listeners
  }

  // ==========================================
  // ➕ OPERACIONES CRUD
  // ==========================================

  /// ➕ Añade una nueva sesión de natación
  /// 
  /// [pools]: Número de piscinas nadadas (debe ser > 0)
  /// [date]: Fecha de la sesión (puede ser pasada o presente)
  /// 
  /// Además de guardar la sesión:
  /// 1. Actualiza automáticamente la racha de días consecutivos
  /// 2. Puede actualizar el mejor récord de racha
  /// 
  /// Este método es crítico para el sistema de motivación (rachas)
  Future<void> addSession(int pools, DateTime date) async {
    if (pools <= 0) return; // Validación: no permitir valores negativos o 0
    
    // Crea sesión (meters se calcula automáticamente: pools × 25)
    final session = SwimmingSession(pools: pools, date: date);
    await _storage.addSession(session);
    _sessions = _storage.getSessions(); // Refresca lista ordenada
    
    // 🔥 Actualizar sistema de rachas
    final settings = _storage.getSettings();
    settings.updateStreak(date); // Calcula días consecutivos
    await _storage.saveSettings(settings); // Persiste nueva racha
    
    notifyListeners(); // Actualiza UI (lista + estadísticas + rachas)
  }

  // ==========================================
  // 📊 ESTADÍSTICAS Y RACHAS
  // ==========================================

  /// 🔥 Obtiene racha actual de días consecutivos
  /// 
  /// Retorna el número de días seguidos nadando
  /// Se reinicia a 1 si pasa más de 1 día sin nadar
  int getCurrentStreak() {
    return _storage.getSettings().currentStreak;
  }

  /// 🏆 Obtiene mejor racha histórica alcanzada
  /// 
  /// Retorna el récord personal de días consecutivos
  /// Este valor nunca disminuye, solo se actualiza si se supera
  int getBestStreak() {
    return _storage.getSettings().bestStreak;
  }

  /// 🎯 Obtiene objetivo semanal de piscinas
  /// 
  /// Por defecto: 100 piscinas/semana (2500 metros)
  /// Personalizable por el usuario
  int getWeeklyGoal() {
    return _storage.getSettings().weeklyGoal;
  }

  /// 📈 Calcula progreso semanal actual
  /// 
  /// Suma todas las piscinas nadadas desde el lunes de esta semana.
  /// La semana empieza en lunes (weekday = 1) y termina en domingo (weekday = 7).
  /// 
  /// Ejemplo: Si hoy es miércoles y has nadado lunes(40) + martes(30) + miércoles(35)
  /// → Retorna: 105 piscinas
  int getWeeklyProgress() {
    final now = DateTime.now();
    // Calcula el lunes de esta semana (weekday: 1=lunes, 7=domingo)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    // Filtra sesiones desde el lunes (inclusive)
    final weekSessions = _sessions.where((session) {
      // Resta 1 día para incluir el lunes en la comparación
      return session.date.isAfter(startOfWeek.subtract(const Duration(days: 1)));
    });
    
    // Suma piscinas de la semana actual
    return weekSessions.fold(0, (sum, session) => sum + session.pools);
  }

  /// 🎯 Establece nuevo objetivo semanal
  /// 
  /// [goal]: Meta de piscinas por semana (debe ser > 0)
  /// Se guarda en UserSettings y persiste entre sesiones
  Future<void> setWeeklyGoal(int goal) async {
    final settings = _storage.getSettings();
    settings.weeklyGoal = goal;
    await _storage.saveSettings(settings);
    notifyListeners(); // Actualiza UI (barra de progreso, tarjeta de objetivo)
  }

  // ==========================================
  // 🗑️ OPERACIONES DE ELIMINACIÓN
  // ==========================================

  /// 🗑️ Elimina una sesión por su índice
  /// 
  /// [index]: Posición de la sesión en la lista ordenada
  /// 
  /// ⚠️ NOTA: Eliminar sesiones NO recalcula rachas
  /// (para evitar complejidad, las rachas solo se calculan al añadir)
  Future<void> deleteSession(int index) async {
    if (index < 0 || index >= _sessions.length) return; // Validación de rango
    
    await _storage.deleteSession(index);
    _sessions = _storage.getSessions(); // Refresca lista
    notifyListeners(); // Actualiza UI (lista + totales)
  }

  /// 🧹 Elimina TODAS las sesiones
  /// 
  /// ⚠️ Acción destructiva (sin confirmación en provider)
  /// La confirmación debe hacerse en la UI antes de llamar esto
  /// 
  /// NOTA: NO resetea las rachas (se mantienen en UserSettings)
  Future<void> clearAllSessions() async {
    await _storage.clearSessions();
    _sessions = []; // Vacía lista local
    notifyListeners(); // UI muestra lista vacía + totales en 0
  }
}
