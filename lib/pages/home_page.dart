/// 🏠 Página de Inicio (Dashboard)
///
/// Esta es la pantalla principal de la aplicación que muestra:
/// - Tarjeta de bienvenida con icono de piscina
/// - Grid de 4 tarjetas de navegación (Preparar, Sesiones, Estadísticas, Exportar)
/// - Tarjeta de racha actual con ícono de fuego
/// - Tarjeta de objetivo semanal con barra de progreso
/// - Resumen rápido con ítems TODO, sesiones y metros totales
///
/// Usa SingleChildScrollView para evitar overflow cuando las tarjetas
/// de racha/objetivo ocupan mucho espacio vertical.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';
import '../providers/todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 🎯 Mostrar diálogo para editar objetivo semanal
  // Permite al usuario cambiar su meta de piscinas por semana
  void _showGoalDialog(BuildContext context, SessionProvider provider) {
    final controller = TextEditingController(
      text: provider.getWeeklyGoal().toString(),
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Objetivo semanal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Piscinas por semana',
            hintText: 'Ej: 100',
            suffixText: 'piscinas',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final goal = int.tryParse(controller.text);
              if (goal != null && goal > 0) {
                provider.setWeeklyGoal(goal);
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piscinapp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 📋 Header de bienvenida
              // Tarjeta destacada con color primario del tema
              Card(
                color: colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.pool,
                        size: 64,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '¡Bienvenido!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Gestiona tu preparación y registra tus sesiones',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // 🎴 Grid de navegación principal (2 columnas x 2 filas)
              // Cada tarjeta navega a una sección diferente de la app
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _MenuCard(
                    icon: Icons.checklist,
                    title: 'Preparar',
                    subtitle: 'Lista TODO',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/todo'),
                  ),
                  _MenuCard(
                    icon: Icons.pool,
                    title: 'Sesiones',
                    subtitle: 'Registrar piscinas',
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/sessions'),
                  ),
                  _MenuCard(
                    icon: Icons.bar_chart,
                    title: 'Estadísticas',
                    subtitle: 'Ver progreso',
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/charts'),
                  ),
                  _MenuCard(
                    icon: Icons.download,
                    title: 'Exportar',
                    subtitle: 'Datos a CSV',
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/export'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // 🔥 Sección de racha y objetivo semanal
              // Consume SessionProvider para mostrar estadísticas en tiempo real
              Consumer<SessionProvider>(
                builder: (context, sessionProvider, child) {
                  final weeklyGoal = sessionProvider.getWeeklyGoal();
                  final weeklyProgress = sessionProvider.getWeeklyProgress();
                  final progressPercent = (weeklyProgress / weeklyGoal * 100).clamp(0, 100);
                  
                  return Column(
                    children: [
                      // 🔥 Tarjeta de racha actual (días consecutivos)
                      Card(
                        color: Colors.orange.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_fire_department,
                                  size: 32,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Racha actual',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '${sessionProvider.getCurrentStreak()}',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'días',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Mejor: ${sessionProvider.getBestStreak()} días',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // 🎯 Tarjeta de objetivo semanal con barra de progreso
                      // Toca el ícono de editar para cambiar el objetivo
                      Card(
                        color: Colors.green.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Objetivo semanal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _showGoalDialog(context, sessionProvider),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$weeklyProgress / $weeklyGoal',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: progressPercent / 100,
                                  minHeight: 12,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progressPercent >= 100 ? Colors.green : Colors.blue,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                progressPercent >= 100
                                    ? '¡Objetivo cumplido! 🎉'
                                    : '${(100 - progressPercent).toStringAsFixed(0)}% restante',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: progressPercent >= 100
                                      ? Colors.green.shade700
                                      : Colors.grey.shade600,
                                  fontWeight: progressPercent >= 100
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              
              // 📊 Resumen rápido con 3 estadísticas principales
              // Consume ambos providers para mostrar información actualizada
              Consumer2<TodoProvider, SessionProvider>(
                builder: (context, todoProvider, sessionProvider, child) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _QuickStat(
                            icon: Icons.checklist,
                            value: todoProvider.todos.length.toString(),
                            label: 'Ítems',
                          ),
                          _QuickStat(
                            icon: Icons.event,
                            value: sessionProvider.sessions.length.toString(),
                            label: 'Sesiones',
                          ),
                          _QuickStat(
                            icon: Icons.straighten,
                            value: '${sessionProvider.totalMeters}m',
                            label: 'Total',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// 🎴 Widget de tarjeta de menú (usada en el grid de navegación)
/// Tarjeta con ícono, título, subtítulo y acción al tocar
/// Cada tarjeta tiene un color temático y navega a una ruta específica
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📊 Widget de estadística rápida (usada en el resumen inferior)
/// Muestra un ícono, valor numérico y etiqueta en formato compacto
/// Ejemplos: "5 Ítems", "12 Sesiones", "300m Total"
class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _QuickStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
