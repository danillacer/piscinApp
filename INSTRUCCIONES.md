# 🏊‍♂️ INSTRUCCIONES DE USO - PISCINA TODO APP

## ✅ PROYECTO COMPLETO Y FUNCIONAL

La aplicación está **100% lista para usar**. Todos los archivos han sido generados y configurados.

## 🚀 Cómo ejecutar la aplicación

### Opción 1: Desde VS Code
1. Abre el proyecto en VS Code
2. Conecta un dispositivo Android o inicia un emulador
3. Presiona `F5` o ve a `Run > Start Debugging`

### Opción 2: Desde la línea de comandos
```bash
flutter run
```

### Opción 3: Compilar APK de producción
```bash
flutter build apk --release
```
El APK estará en: `build/app/outputs/flutter-apk/app-release.apk`

## 📱 Funcionalidades de la app

### PANTALLA 1: Preparar la piscina (📝 TODO)
**Navegación**: Primer botón en la barra inferior

**Funciones:**
- ➕ **Añadir ítem**: Escribe el texto y presiona "Añadir"
- ✅ **Marcar/Desmarcar**: Toca el checkbox o el ítem completo
- 🗑️ **Borrar ítem**: Presiona el ícono de papelera en cada ítem
- 📌 **Chincheta (función especial)**:
  - Presiona el ícono de chincheta en la barra superior
  - Guarda la lista actual como "lista base"
  - Cada vez que abras la app, esta lista aparecerá automáticamente
  - Los ítems aparecen desmarcados para reutilizar
  
**Menú de opciones** (tres puntos arriba a la derecha):
- ✅ Marcar todos
- ⬜ Desmarcar todos
- 🗑️ Borrar todos

### PANTALLA 2: Registro de sesiones (🏊)
**Navegación**: Segundo botón en la barra inferior

**Funciones:**
- 📝 **Añadir sesión**:
  1. Ingresa el número de piscinas
  2. Selecciona la fecha (por defecto: hoy)
  3. Presiona "Guardar sesión"
  4. Automáticamente calcula: piscinas × 25 = metros

- 📊 **Estadísticas**: Muestra totales de:
  - Total de piscinas
  - Total de metros nadados

- 📜 **Historial**: Lista de todas las sesiones con:
  - Número de piscinas
  - Metros equivalentes
  - Fecha de la sesión
  - Botón para eliminar sesión

### PANTALLA 3: Estadísticas (📈)
**Navegación**: Tercer botón en la barra inferior

**Visualizaciones:**
- 📊 **Gráfica de barras**: Muestra piscinas por fecha
  - Toca una barra para ver detalles
  - Scroll horizontal si hay muchas sesiones
  
- 📋 **Resumen estadístico**:
  - Total de sesiones
  - Total de piscinas
  - Total de metros
  - Promedio de piscinas por sesión

## 💾 Persistencia de datos

**TODO LO SE GUARDA AUTOMÁTICAMENTE:**
- ✅ Lista TODO actual
- 📌 Lista base (chincheta)
- 🏊 Todas las sesiones de natación

Los datos persisten incluso si cierras la app completamente.

## 🎨 Diseño

- **Material Design 3**: Interfaz moderna y limpia
- **Tema adaptable**: Se adapta al tema del sistema (claro/oscuro)
- **Navegación intuitiva**: Bottom Navigation Bar con 3 secciones
- **Iconografía clara**: Iconos descriptivos en cada función
- **Colores**: Tonos azules relacionados con el agua/piscina

## 🔧 Comandos útiles

```bash
# Ver dispositivos conectados
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# Ejecutar en modo release (más rápido)
flutter run --release

# Limpiar y reconstruir
flutter clean
flutter pub get
flutter run

# Ver logs en tiempo real
flutter logs

# Analizar código
flutter analyze

# Ejecutar tests (si los hubiera)
flutter test
```

## 📁 Estructura del proyecto

```
lib/
├── main.dart                    # Inicialización de la app
├── app.dart                     # Configuración y navegación principal
├── models/
│   ├── todo_item.dart          # Modelo de ítem TODO
│   ├── todo_item.g.dart        # Adaptador Hive (generado)
│   ├── swimming_session.dart   # Modelo de sesión
│   └── swimming_session.g.dart # Adaptador Hive (generado)
├── providers/
│   ├── todo_provider.dart      # Estado de la lista TODO
│   └── session_provider.dart   # Estado de las sesiones
├── pages/
│   ├── todo_page.dart          # Pantalla lista TODO
│   ├── sessions_page.dart      # Pantalla registro sesiones
│   └── charts_page.dart        # Pantalla estadísticas
├── widgets/
│   └── todo_item_widget.dart   # Widget de ítem TODO
└── services/
    └── storage_service.dart    # Servicio de persistencia Hive
```

## 🛠️ Tecnologías implementadas

✅ **Flutter** - Framework multiplataforma
✅ **Provider** - Gestión de estado reactivo
✅ **Hive** - Base de datos NoSQL local
✅ **fl_chart** - Gráficas interactivas
✅ **intl** - Internacionalización (fechas en español)
✅ **flutter_launcher_icons** - Icono personalizado

## 📱 Icono de la app

Se ha generado un icono personalizado mostrando una persona nadando:
- ✅ Icono regular (cuadrado con fondo azul)
- ✅ Icono adaptable Android (foreground + background)
- 🎨 Colores: Azul piscina (#0288D1)

## ⚠️ Solución de problemas

### La app no compila
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Error con Hive
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### El icono no aparece
```bash
flutter pub run flutter_launcher_icons
flutter clean
flutter run
```

### Errores de dependencias
```bash
flutter pub upgrade
flutter pub get
```

## 📝 Notas importantes

1. **Primera ejecución**: Puede tardar más (compilación inicial)
2. **Hot Reload**: Presiona `r` en la terminal para recargar cambios
3. **Hot Restart**: Presiona `R` para reiniciar completamente
4. **Detener app**: Presiona `q` en la terminal

## 🎯 ¡LA APP ESTÁ LISTA!

No necesitas modificar nada. La aplicación está **completamente funcional** con:
- ✅ Todas las funcionalidades solicitadas
- ✅ Persistencia de datos
- ✅ Diseño moderno y limpio
- ✅ Icono personalizado
- ✅ Código bien estructurado
- ✅ Sin errores ni warnings

**Simplemente ejecuta `flutter run` y comienza a usarla.**

---

Desarrollado como proyecto Flutter completo y funcional.
