# 📋 Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

---

## [1.0.0] - 2025-11-19

### 🎉 Lanzamiento Inicial

Primera versión pública de **Piscinapp** - Tu compañero de natación.

### ✨ Funcionalidades

#### 📝 Lista TODO
- Crear, editar y eliminar tareas de preparación
- Marcar/desmarcar ítems como completados
- Reordenar ítems mediante drag & drop
- Edición inline con doble clic
- Guardar lista base con chincheta (📌)
- Acciones masivas: marcar todos, desmarcar todos, eliminar todos

#### 🏊 Registro de Sesiones
- Añadir sesiones con número de piscinas nadadas
- Conversión automática a metros (25m por piscina)
- Selector de fecha para sesiones pasadas
- Historial completo de sesiones
- Eliminar sesiones individuales
- Cálculo automático de totales

#### 📊 Estadísticas
- Gráfica de barras: piscinas por fecha
- Gráfica de línea: progreso acumulado
- Sistema de rachas (días consecutivos)
- Objetivos semanales personalizables
- Progreso semanal con barra visual
- Resumen de estadísticas totales

#### 💾 Exportación
- Exportar sesiones a CSV
- Exportar lista TODO a CSV
- Archivos con timestamp automático
- Visualización de ruta de guardado

#### 🎨 Interfaz
- Splash screen animado con degradado
- Pantalla de inicio con dashboard de tarjetas
- Diseño Material Design 3
- Tema azul/celeste (colores piscina)
- Navegación fluida entre secciones
- Iconos descriptivos

#### 💾 Persistencia
- Base de datos Hive (NoSQL local)
- Almacenamiento de sesiones
- Guardado de lista TODO
- Persistencia de lista base (chincheta)
- Configuración de usuario (objetivos/rachas)

### 🛠 Tecnologías

- **Flutter**: 3.5.4
- **Dart**: 3.5.4
- **Hive**: 2.2.3 (base de datos)
- **Provider**: 6.1.2 (estado)
- **fl_chart**: 0.69.0 (gráficas)
- **path_provider**: 2.1.4 (archivos)
- **intl**: 0.20.2 (fechas/localización)

### 📱 Plataformas

- ✅ Android (probado)
- ⏳ iOS (pendiente pruebas)

---

## [Unreleased]

### 🚀 Próximas Funcionalidades

Estas características están planificadas para futuras versiones:

- [ ] Notificaciones de recordatorio
- [ ] Widget para pantalla de inicio
- [ ] Sincronización en la nube
- [ ] Múltiples perfiles de usuario
- [ ] Modo oscuro
- [ ] Importar datos desde CSV
- [ ] Compartir progreso en redes sociales
- [ ] Integración con wearables
- [ ] Más tipos de gráficas

---

## Formato de Versiones

### Tipos de cambios:
- **✨ Added**: Nuevas funcionalidades
- **🔧 Changed**: Cambios en funcionalidad existente
- **🗑️ Deprecated**: Funcionalidades obsoletas
- **❌ Removed**: Funcionalidades eliminadas
- **🐛 Fixed**: Corrección de bugs
- **🔒 Security**: Parches de seguridad

---

## [0.9.0] - 2025-11-18 (Pre-release)

### ✨ Added
- Sistema de objetivos semanales
- Cálculo automático de rachas
- Gráfica de progreso acumulado (línea)
- Splash screen animado
- Pantalla de inicio con dashboard

### 🔧 Changed
- Rediseño de navegación (sin BottomNavigationBar)
- Home page como pantalla principal
- Mejora en diseño de tarjetas

### 🐛 Fixed
- Error de keys duplicadas en Hive (chincheta)
- Deprecación de withOpacity() → withValues(alpha:)

---

## [0.8.0] - 2025-11-17

### ✨ Added
- Exportación a CSV (sesiones y TODO)
- Edición inline de ítems TODO (doble clic)

### 🔧 Changed
- Navegación rediseñada con home dashboard

---

## [0.7.0] - 2025-11-16

### ✨ Added
- Drag & drop para reordenar ítems TODO
- Iconos de arrastre visuales

---

## [0.6.0] - 2025-11-15

### ✨ Added
- Funcionalidad de chincheta (guardar lista base)

### 🐛 Fixed
- Error al guardar lista base con ítems existentes en Hive
- Solución: crear copias de TodoItems

---

## [0.5.0] - 2025-11-14

### ✨ Added
- Gráfica de barras en estadísticas
- Visualización de datos históricos

---

## [0.1.0 - 0.4.0] - 2025-11-10 / 2025-11-13

### ✨ Added
- Estructura inicial del proyecto
- Modelos con Hive
- Providers con Provider pattern
- Páginas principales (TODO, Sesiones)
- Persistencia de datos
- Conversión automática piscinas → metros

---

**Leyenda de versiones:**
- **Major** (1.0.0): Cambios incompatibles con versiones anteriores
- **Minor** (0.1.0): Nuevas funcionalidades compatibles
- **Patch** (0.0.1): Correcciones de bugs

---

Para ver cambios detallados, consulta los [commits en GitHub](../../commits/main).
