// 📦 Importaciones necesarias
import 'package:flutter/material.dart';
import 'app.dart';
import 'services/storage_service.dart';

/// 🚀 Punto de entrada principal de la aplicación Piscinapp
/// 
/// Esta función se ejecuta al iniciar la app y realiza:
/// 1. Inicialización de bindings de Flutter (necesario para operaciones async antes de runApp)
/// 2. Inicialización de la base de datos Hive (StorageService)
/// 3. Lanzamiento de la aplicación (MyApp)
void main() async {
  // Asegura que los bindings de Flutter estén inicializados antes de operaciones async
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Hive y abre todas las cajas de datos (todos, baseList, sessions, settings)
  await StorageService.init();
  
  // Lanza la aplicación
  runApp(const MyApp());
}
