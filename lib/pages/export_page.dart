import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../providers/session_provider.dart';
import '../providers/todo_provider.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

  Future<String> _exportSessionsToCSV(List sessions) async {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final buffer = StringBuffer();
    
    // Encabezados
    buffer.writeln('Fecha,Piscinas,Metros');
    
    // Datos
    for (var session in sessions) {
      buffer.writeln('${dateFormat.format(session.date)},${session.pools},${session.meters}');
    }
    
    // Guardar archivo
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${directory.path}/sesiones_piscina_$timestamp.csv');
    await file.writeAsString(buffer.toString());
    
    return file.path;
  }

  Future<String> _exportTodosToCSV(List todos) async {
    final buffer = StringBuffer();
    
    // Encabezados
    buffer.writeln('Item,Completado');
    
    // Datos
    for (var todo in todos) {
      final completado = todo.isCompleted ? 'Sí' : 'No';
      buffer.writeln('"${todo.text}",$completado');
    }
    
    // Guardar archivo
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${directory.path}/lista_todo_$timestamp.csv');
    await file.writeAsString(buffer.toString());
    
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar datos'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.file_download,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Exportar tus datos',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Exporta tus sesiones y lista TODO a formato CSV para usar en Excel, Google Sheets u otras aplicaciones.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Exportar sesiones
              Consumer<SessionProvider>(
                builder: (context, provider, child) {
                  return _ExportCard(
                    icon: Icons.pool,
                    title: 'Exportar sesiones',
                    subtitle: '${provider.sessions.length} sesiones registradas',
                    color: Colors.blue,
                    enabled: provider.sessions.isNotEmpty,
                    onTap: () async {
                      try {
                        final path = await _exportSessionsToCSV(provider.sessions);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Exportado a:\n$path'),
                              duration: const Duration(seconds: 4),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al exportar: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // Exportar TODOs
              Consumer<TodoProvider>(
                builder: (context, provider, child) {
                  return _ExportCard(
                    icon: Icons.checklist,
                    title: 'Exportar lista TODO',
                    subtitle: '${provider.todos.length} ítems en la lista',
                    color: Colors.green,
                    enabled: provider.todos.isNotEmpty,
                    onTap: () async {
                      try {
                        final path = await _exportTodosToCSV(provider.todos);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Exportado a:\n$path'),
                              duration: const Duration(seconds: 4),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al exportar: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Información
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Los archivos CSV se guardan en la carpeta de documentos de la aplicación.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  const _ExportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: enabled ? 2 : 0,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: enabled ? color.withValues(alpha: 0.1) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: enabled ? color : Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: enabled ? null : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: enabled ? null : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
