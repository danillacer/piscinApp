import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/storage_service.dart';
import 'providers/todo_provider.dart';
import 'providers/session_provider.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/todo_page.dart';
import 'pages/sessions_page.dart';
import 'pages/charts_page.dart';
import 'pages/export_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(StorageService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SessionProvider(StorageService()),
        ),
      ],
      child: MaterialApp(
        title: 'Piscinapp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
        ],
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const HomePage(),
          '/todo': (context) => const TodoPage(),
          '/sessions': (context) => const SessionsPage(),
          '/charts': (context) => const ChartsPage(),
          '/export': (context) => const ExportPage(),
        },
      ),
    );
  }
}
