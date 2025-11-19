<div align="center">

# 🏊‍♂️ Piscinapp

### Tu compañero de natación personal

[![Flutter](https://img.shields.io/badge/Flutter-3.5.4-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

**Gestiona tu equipamiento de piscina y haz seguimiento de tus sesiones de natación**

[🇪🇸 README Completo](README_PROYECTO.md) • [📚 Documentación](docs/) • [❓ FAQ](FAQ.md)

</div>

---

## 📖 Índice de Documentación

Este proyecto incluye documentación completa para diferentes propósitos:

### 📘 Para Usuarios
- **[README_PROYECTO.md](README_PROYECTO.md)** - README principal para GitHub con capturas y guía completa
- **[FAQ.md](FAQ.md)** - Preguntas frecuentes
- **[CHANGELOG.md](CHANGELOG.md)** - Historial de cambios y versiones

### 👨‍💻 Para Desarrolladores
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Cómo contribuir al proyecto
- **[COMMANDS.md](COMMANDS.md)** - Comandos útiles de Flutter/Dart
- **[docs/SCREENSHOTS_GUIDE.md](docs/SCREENSHOTS_GUIDE.md)** - Guía para tomar capturas
- **[scripts/dev.ps1](scripts/dev.ps1)** - Script de utilidades

### 🔒 Seguridad y Políticas
- **[SECURITY.md](SECURITY.md)** - Política de seguridad
- **[LICENSE](LICENSE)** - Licencia MIT

### 📋 Gestión de Proyecto
- **[CHECKLIST_FINAL.md](CHECKLIST_FINAL.md)** - Estado del proyecto y verificaciones
- **[PROYECTO_COMPLETO.md](PROYECTO_COMPLETO.md)** - Documentación técnica completa
- **[RESUMEN_EJECUTIVO.md](RESUMEN_EJECUTIVO.md)** - Resumen ejecutivo

---

## 🚀 Inicio Rápido

Aplicación Flutter para gestionar equipamiento de piscina y registrar sesiones de natación.

## Características

### 🏊‍♂️ Lista TODO para preparar la piscina
- Añadir, editar y eliminar ítems
- Marcar/desmarcar ítems completados
- Funciones globales: Marcar todos, Desmarcar todos, Borrar todos
- **Chincheta**: Guardar lista base que se carga automáticamente al abrir la app

### 📊 Registro de sesiones
- Registrar número de piscinas realizadas
- Seleccionar fecha de la sesión
- Conversión automática a metros (1 piscina = 25m)
- Historial completo de sesiones

### 📈 Estadísticas y gráficas
- Gráfica de barras con piscinas por fecha
- Estadísticas totales: sesiones, piscinas, metros
- Promedio de piscinas por sesión

## Instalación

### 1. Instalar dependencias

```bash
flutter pub get
```

### 2. Generar adaptadores de Hive

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Generar iconos de la app

**IMPORTANTE**: Antes de generar los iconos, debes convertir el SVG a PNG:

#### Opción A: Usar herramienta online
1. Abre `assets/icon/swimmer_icon.svg` en un navegador
2. Usa una herramienta como https://svgtopng.com/ o https://cloudconvert.com/svg-to-png
3. Exporta dos versiones:
   - `app_icon.png` - 1024x1024px (icono completo)
   - `app_icon_foreground.png` - 1024x1024px (sin fondo, solo el nadador)

#### Opción B: Usar ImageMagick (línea de comandos)
```bash
# Si tienes ImageMagick instalado
magick convert -density 300 -background transparent assets/icon/swimmer_icon.svg -resize 1024x1024 assets/icon/app_icon.png
magick convert -density 300 -background transparent assets/icon/swimmer_icon.svg -resize 1024x1024 assets/icon/app_icon_foreground.png
```

#### Opción C: Usar Inkscape
```bash
inkscape --export-type=png --export-filename=assets/icon/app_icon.png --export-width=1024 --export-height=1024 assets/icon/swimmer_icon.svg
```

Una vez que tengas los archivos PNG, genera los iconos:

```bash
flutter pub run flutter_launcher_icons
```

### 4. Ejecutar la app

```bash
flutter run
```

## Arquitectura del proyecto

```
lib/
├─ main.dart                  # Punto de entrada
├─ app.dart                   # Configuración de la app y navegación
├─ models/
│  ├─ todo_item.dart         # Modelo de ítem TODO
│  └─ swimming_session.dart  # Modelo de sesión de natación
├─ providers/
│  ├─ todo_provider.dart     # Gestión de estado de TODOs
│  └─ session_provider.dart  # Gestión de estado de sesiones
├─ pages/
│  ├─ todo_page.dart         # Pantalla de lista TODO
│  ├─ sessions_page.dart     # Pantalla de registro de sesiones
│  └─ charts_page.dart       # Pantalla de estadísticas
├─ widgets/
│  └─ todo_item_widget.dart  # Widget de ítem TODO
├─ services/
│  └─ storage_service.dart   # Servicio de persistencia con Hive
└─ utils/
```

## Tecnologías utilizadas

- **Flutter** - Framework UI
- **Provider** - Gestión de estado
- **Hive** - Base de datos local (NoSQL)
- **fl_chart** - Gráficas y visualizaciones
- **intl** - Internacionalización y formatos de fecha

## Persistencia de datos

La aplicación usa **Hive** para almacenar:
- Lista TODO actual
- Lista base (chincheta)
- Historial de sesiones de natación

Los datos persisten entre sesiones de la app automáticamente.

## Funcionalidad de la chincheta 📌

Al presionar el icono de chincheta en la pantalla TODO:
1. Se guarda la lista actual como "lista base"
2. Cada vez que abras la app, esta lista aparecerá automáticamente
3. Los ítems aparecen desmarcados para usar de nuevo
4. El icono se ilumina cuando hay una lista base guardada

## Compilación para producción

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### Android (versión optimizada por ABI)
```bash
flutter build apk --split-per-abi --release
```

El APK estará en: `build/app/outputs/flutter-apk/`

## 📚 Más Información

Para documentación completa, capturas de pantalla y detalles del proyecto, consulta:
- 📘 **[README_PROYECTO.md](README_PROYECTO.md)** - Documentación completa
- ❓ **[FAQ.md](FAQ.md)** - Preguntas frecuentes
- 🤝 **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guía de contribución
- 🛠️ **[COMMANDS.md](COMMANDS.md)** - Referencia de comandos

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**¿Te gusta el proyecto? ¡Dale una ⭐ en GitHub!**

</div>
