// 📦 Importación de Hive para persistencia de datos
import 'package:hive/hive.dart';

// 🔧 Archivo generado automáticamente por build_runner con el adapter de Hive
part 'user_settings.g.dart';

/// ⚙️ Modelo de configuración del usuario y estadísticas de progreso
/// 
/// Almacena:
/// - Objetivos personalizables (meta semanal de piscinas)
/// - Sistema de rachas (días consecutivos nadando)
/// - Preferencias de tema (futuro)
/// 
/// Usa Hive para persistencia local (NoSQL):
/// - TypeId: 2 (identificador único del tipo en Hive)
/// - Solo existe una instancia de configuración por usuario
@HiveType(typeId: 2)
class UserSettings extends HiveObject {
  /// 🎯 Objetivo semanal de piscinas nadadas
  /// Por defecto: 100 piscinas/semana (2500 metros)
  /// Editable por el usuario desde la interfaz
  @HiveField(0)
  int weeklyGoal;

  /// 🔥 Racha actual: días consecutivos nadando
  /// Se reinicia a 1 si pasa más de 1 día sin nadar
  /// Se incrementa +1 por cada día consecutivo
  @HiveField(1)
  int currentStreak;

  /// 🏆 Mejor racha histórica alcanzada
  /// Guarda el récord personal de días consecutivos
  /// Nunca disminuye, solo se actualiza si se supera
  @HiveField(2)
  int bestStreak;

  /// 📅 Fecha de la última sesión registrada
  /// Usado para calcular rachas y detectar días consecutivos
  /// null si el usuario nunca ha nadado
  @HiveField(3)
  DateTime? lastSessionDate;

  /// 🎨 Tema seleccionado por el usuario
  /// Preparado para futuro (modo oscuro, colores personalizados)
  /// Opciones: 'blue' (default), 'dark', 'custom'
  @HiveField(4)
  String? selectedTheme;

  /// 🏗️ Constructor de configuración del usuario
  /// 
  /// Valores por defecto:
  /// - weeklyGoal: 100 piscinas (2500m)
  /// - currentStreak: 0 días
  /// - bestStreak: 0 días
  /// - lastSessionDate: null (sin sesiones)
  /// - selectedTheme: 'blue'
  UserSettings({
    this.weeklyGoal = 100,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.lastSessionDate,
    this.selectedTheme = 'blue',
  });

  /// 🔄 Actualiza la racha de días consecutivos
  /// 
  /// Lógica de cálculo:
  /// - Primera sesión: racha = 1
  /// - Día consecutivo (diff = 1 día): racha++
  /// - Más de 1 día sin nadar: racha se reinicia a 1
  /// - Mismo día: racha no cambia
  /// 
  /// También actualiza bestStreak si se supera el récord
  /// 
  /// [newSessionDate]: Fecha de la nueva sesión registrada
  void updateStreak(DateTime newSessionDate) {
    // 🆕 Primera sesión del usuario
    if (lastSessionDate == null) {
      currentStreak = 1;
      lastSessionDate = newSessionDate;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak; // Primera vez, actualiza récord
      }
      return;
    }

    // 📊 Calcula días de diferencia entre sesiones
    final daysDifference = newSessionDate.difference(lastSessionDate!).inDays;

    if (daysDifference == 1) {
      // ✅ Día consecutivo: incrementa racha
      currentStreak++;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak; // Nuevo récord personal
      }
    } else if (daysDifference > 1) {
      // ❌ Se rompió la racha: reinicia a 1
      currentStreak = 1;
    }
    // ⚠️ Si daysDifference == 0 (mismo día), la racha no cambia

    // Actualiza fecha de última sesión
    lastSessionDate = newSessionDate;
  }

  /// 📤 Serializa la configuración a JSON para exportación
  /// 
  /// Convierte el objeto a un mapa con formato JSON
  /// Útil para backup o migración de datos
  Map<String, dynamic> toJson() {
    return {
      'weeklyGoal': weeklyGoal,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'lastSessionDate': lastSessionDate?.toIso8601String(), // null-safe
      'selectedTheme': selectedTheme,
    };
  }

  /// 📥 Deserializa JSON a un objeto UserSettings
  /// 
  /// Factory constructor que crea configuración desde un mapa JSON
  /// Todos los campos tienen valores por defecto si son null
  /// Útil para restaurar configuración desde backup
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      weeklyGoal: json['weeklyGoal'] as int? ?? 100, // Default: 100
      currentStreak: json['currentStreak'] as int? ?? 0, // Default: 0
      bestStreak: json['bestStreak'] as int? ?? 0, // Default: 0
      lastSessionDate: json['lastSessionDate'] != null
          ? DateTime.parse(json['lastSessionDate'] as String)
          : null, // null si no existe
      selectedTheme: json['selectedTheme'] as String? ?? 'blue', // Default: blue
    );
  }
}
