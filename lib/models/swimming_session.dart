// 📦 Importación de Hive para persistencia de datos
import 'package:hive/hive.dart';

// 🔧 Archivo generado automáticamente por build_runner con el adapter de Hive
part 'swimming_session.g.dart';

/// 🏊 Modelo de datos para una sesión de natación
/// 
/// Registra una sesión completa de natación con:
/// - Número de piscinas nadadas (longitudes de 25m)
/// - Conversión automática a metros totales
/// - Fecha de la sesión
/// 
/// Usa Hive para persistencia local (NoSQL):
/// - TypeId: 1 (identificador único del tipo en Hive)
/// - Extiende HiveObject para funcionalidades de eliminación
@HiveType(typeId: 1)
class SwimmingSession extends HiveObject {
  /// 🏊 Número de piscinas (longitudes) nadadas en la sesión
  /// Cada piscina equivale a 25 metros
  @HiveField(0)
  int pools;

  /// 📏 Total de metros nadados
  /// Se calcula automáticamente: pools × 25
  /// Ejemplo: 40 piscinas = 1000 metros
  @HiveField(1)
  int meters;

  /// 📅 Fecha de la sesión de natación
  /// Permite registrar sesiones pasadas o del día actual
  @HiveField(2)
  DateTime date;

  /// 🏗️ Constructor de sesión de natación
  /// 
  /// [pools]: Número de piscinas nadadas (requerido)
  /// [date]: Fecha de la sesión (requerido)
  /// 
  /// El campo [meters] se calcula automáticamente en la inicialización
  /// multiplicando pools × 25 (longitud estándar de piscina)
  SwimmingSession({
    required this.pools,
    required this.date,
  }) : meters = pools * 25; // Conversión automática: 1 piscina = 25 metros

  /// 📤 Serializa la sesión a JSON para exportación (CSV)
  /// 
  /// Convierte el objeto a un mapa con formato JSON
  /// La fecha se serializa en formato ISO 8601 (YYYY-MM-DD)
  Map<String, dynamic> toJson() {
    return {
      'pools': pools,
      'meters': meters,
      'date': date.toIso8601String(), // Formato: "2025-11-19T10:30:00.000"
    };
  }

  /// 📥 Deserializa JSON a un objeto SwimmingSession
  /// 
  /// Factory constructor que crea una sesión desde un mapa JSON
  /// Útil para importar datos desde CSV o restaurar backup
  factory SwimmingSession.fromJson(Map<String, dynamic> json) {
    return SwimmingSession(
      pools: json['pools'] as int,
      date: DateTime.parse(json['date'] as String), // Parsea fecha ISO 8601
    );
  }
}
