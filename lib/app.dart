// 📦 Importaciones de Flutter y paquetes externos
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Gestión de estado
import 'package:flutter_localizations/flutter_localizations.dart'; // Localización en español

// 📦 Importaciones de servicios, providers y páginas de la app
import 'services/storage_service.dart';
import 'providers/todo_provider.dart';
import 'providers/session_provider.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/todo_page.dart';
import 'pages/sessions_page.dart';
import 'pages/charts_page.dart';
import 'pages/export_page.dart';

/// 🏗️ Widget raíz de la aplicación Piscinapp
/// 
/// Configura:
/// - Providers de estado (Provider pattern)
/// - Tema de la aplicación (Material Design 3)
/// - Rutas de navegación
/// - Localización en español
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔄 MultiProvider: Proporciona múltiples providers a toda la app
    return MultiProvider(
      providers: [
        // Provider para gestión de la lista TODO
        ChangeNotifierProvider(
          create: (_) => TodoProvider(StorageService()),
        ),
        // Provider para gestión de sesiones de natación
        ChangeNotifierProvider(
          create: (_) => SessionProvider(StorageService()),
        ),
      ],
      child: MaterialApp(
        // ⚙️ Configuración básica de la app
        title: 'Piscinapp',
        debugShowCheckedModeBanner: false, // Oculta banner de debug
        
        // 🎨 Tema claro (Material Design 3)
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, // Color principal: azul (tema piscina)
            brightness: Brightness.light,
          ),
          useMaterial3: true, // Activa Material Design 3
        ),
        
        // 🌙 Tema oscuro (preparado para futuro)
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        
        // 🌍 Configuración de localización en español
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // Textos de Material en español
          GlobalWidgetsLocalizations.delegate, // Widgets en español
          GlobalCupertinoLocalizations.delegate, // Cupertino en español
        ],
        supportedLocales: const [
          Locale('es', 'ES'), // Español de España
        ],
        
        // 🗺️ Rutas de navegación de la app
        initialRoute: '/splash', // Ruta inicial: splash screen
        routes: {
          '/splash': (context) => const SplashScreen(), // Pantalla de carga animada
          '/': (context) => const HomePage(), // Dashboard principal
          '/todo': (context) => const TodoPage(), // Lista TODO
          '/sessions': (context) => const SessionsPage(), // Registro de sesiones
          '/charts': (context) => const ChartsPage(), // Estadísticas y gráficas
          '/export': (context) => const ExportPage(), // Exportación CSV
        },
      ),
    );
  }
}
