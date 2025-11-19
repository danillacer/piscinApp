// 📦 Importación de Hive para persistencia de datos
import 'package:hive/hive.dart';

// 🔧 Archivo generado automáticamente por build_runner con el adapter de Hive
part 'todo_item.g.dart';

/// 📝 Modelo de datos para un ítem de la lista TODO
/// 
/// Representa un elemento de la lista de preparación para ir a la piscina.
/// Ejemplos: "Gafas", "Gorro", "Bañador", etc.
/// 
/// Usa Hive para persistencia local (NoSQL):
/// - TypeId: 0 (identificador único del tipo en Hive)
/// - Extiende HiveObject para funcionalidades adicionales (delete, save)
@HiveType(typeId: 0)
class TodoItem extends HiveObject {
  /// 📄 Texto descriptivo del ítem (ej: "Gafas de natación")
  @HiveField(0)
  String text;

  /// ✅ Estado de completado del ítem
  /// - true: ítem marcado (preparado)
  /// - false: ítem pendiente
  @HiveField(1)
  bool isCompleted;

  /// 🏗️ Constructor del ítem TODO
  /// 
  /// [text]: Descripción del ítem (requerido)
  /// [isCompleted]: Estado inicial (por defecto: false/pendiente)
  TodoItem({
    required this.text,
    this.isCompleted = false,
  });

  /// 📤 Serializa el ítem a JSON para exportación (CSV)
  /// 
  /// Convierte el objeto a un mapa clave-valor
  /// Útil para exportar datos o logging
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  /// 📥 Deserializa JSON a un objeto TodoItem
  /// 
  /// Factory constructor que crea un TodoItem desde un mapa JSON
  /// Útil para importar datos o restaurar desde backup
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      text: json['text'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false, // Default: false si es null
    );
  }
}
