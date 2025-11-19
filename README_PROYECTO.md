<div align="center">

# 🏊‍♂️ Piscinapp

### Tu compañero de natación personal

[![Flutter](https://img.shields.io/badge/Flutter-3.5.4-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Android](https://img.shields.io/badge/Android-Ready-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://www.android.com)

**Gestiona tu equipamiento de piscina y haz seguimiento de tus sesiones de natación de forma simple y efectiva.**

[Características](#-características) • [Capturas](#-capturas-de-pantalla) • [Instalación](#-instalación) • [Uso](#-cómo-usar) • [Contribuir](#-contribuir)

<!-- Descomentar cuando tengas las capturas
<img src="docs/screenshots/home.png" width="250" alt="Pantalla de inicio">
-->

</div>

---

## ✨ Características

### 📝 **Lista TODO Inteligente**
- ✅ Gestiona tu equipamiento de piscina (gafas, gorro, toalla, etc.)
- 🔄 Reordena ítems con drag & drop
- ✏️ Edita ítems con doble click
- 📌 **Función Chincheta**: Guarda tu lista base permanentemente
- 🔁 La lista base se carga automáticamente al abrir la app

### 🏊 **Registro de Sesiones**
- 📊 Registra cuántas piscinas has hecho en cada sesión
- 📅 Selecciona la fecha de cada sesión
- 🔢 Conversión automática: **piscinas × 25 = metros**
- 💾 Historial completo con persistencia local
- 🔥 Sistema de rachas: mantén tu motivación alta

### 📈 **Estadísticas y Objetivos**
- 📊 **Gráfica de barras**: Visualiza piscinas por fecha
- 📈 **Gráfica de progreso**: Seguimiento acumulado en el tiempo
- 🎯 **Objetivos semanales**: Establece y alcanza tus metas
- 🔥 **Racha de días**: Cuenta tus días consecutivos nadando
- 📋 Resumen completo: totales, promedios y récords

### 📥 **Exportación de Datos**
- 📄 Exporta sesiones a **CSV** para Excel/Sheets
- 📄 Exporta lista TODO a CSV
- 💾 Archivos guardados con timestamp automático

### 🎨 **Experiencia de Usuario**
- 🌊 Splash screen animado profesional
- 🎨 Diseño Material Design 3
- 🌙 Tema adaptable (claro/oscuro según sistema)
- ⚡ Rendimiento optimizado con Hive DB
- 📱 Interfaz intuitiva y moderna

---

## 📸 Capturas de pantalla

<!-- Instrucciones para agregar capturas: ver docs/SCREENSHOTS_GUIDE.md -->

<div align="center">

<!--
Descomentar cuando tengas las capturas listas

### Pantalla Principal
<img src="docs/screenshots/home.png" width="250" alt="Home">

*Dashboard con acceso rápido, racha actual y objetivo semanal*

### Lista TODO
<img src="docs/screenshots/todo.png" width="250" alt="TODO">

*Gestiona tu equipamiento con drag & drop y chincheta*

### Registro de Sesiones
<img src="docs/screenshots/sessions.png" width="250" alt="Sessions">

*Registra tus piscinas con conversión automática a metros*

### Estadísticas
<img src="docs/screenshots/stats.png" width="250" alt="Stats">

*Visualiza tu progreso con múltiples gráficas*

### Exportación
<img src="docs/screenshots/export.png" width="250" alt="Export">

*Exporta tus datos a CSV*
-->

_📸 Capturas de pantalla próximamente. Ver [guía para capturas](docs/SCREENSHOTS_GUIDE.md)_

</div>

---

## 🚀 Instalación

### Requisitos previos
- **Flutter SDK** (3.0 o superior)
- **Android Studio** o **VS Code**
- Dispositivo Android o emulador

### Pasos de instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/TU_USUARIO/piscinapp.git
cd piscinapp
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Generar archivos de código**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Ejecutar la aplicación**
```bash
flutter run
```

### Descargar APK

Descarga la última versión directamente desde [Releases](https://github.com/TU_USUARIO/piscinapp/releases)

---

## 📖 Cómo usar

### 1️⃣ Preparar tu equipamiento

1. Abre la sección **"Preparar"**
2. Añade ítems a tu lista (gafas, gorro, bañador, etc.)
3. Presiona el icono **≡** para reordenar con drag & drop
4. Haz **doble click** en un ítem para editarlo
5. Presiona la **📌 chincheta** para guardar tu lista base

### 2️⃣ Registrar una sesión

1. Ve a **"Sesiones"**
2. Ingresa cuántas piscinas hiciste
3. Selecciona la fecha (por defecto es hoy)
4. Presiona **"Guardar sesión"**
5. ¡Los metros se calculan automáticamente!

### 3️⃣ Ver tus estadísticas

1. Abre **"Estadísticas"**
2. Revisa tus gráficas de progreso
3. Observa tu racha actual y récord
4. Verifica el progreso de tu objetivo semanal

### 4️⃣ Configurar tu objetivo

1. En la pantalla de inicio, toca el **icono de edición** junto a "Objetivo semanal"
2. Ingresa tu meta de piscinas por semana
3. El progreso se actualizará automáticamente

### 5️⃣ Exportar tus datos

1. Ve a **"Exportar"**
2. Elige qué datos exportar (sesiones o lista TODO)
3. Los archivos CSV se guardan automáticamente
4. Ábrelos en Excel, Google Sheets, etc.

---

## 🛠 Tecnologías

| Tecnología | Propósito | Versión |
|------------|-----------|---------|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white) | Framework UI multiplataforma | 3.5.4 |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white) | Lenguaje de programación | 3.5.4 |
| ![Provider](https://img.shields.io/badge/Provider-EE4C2C?logo=flutter) | Gestión de estado reactiva | 6.1.2 |
| ![Hive](https://img.shields.io/badge/Hive-FFA000?logo=hive) | Base de datos NoSQL local | 2.2.3 |
| ![fl_chart](https://img.shields.io/badge/fl__chart-4CAF50?logo=chartdotjs) | Gráficas interactivas | 0.69.0 |
| ![Material 3](https://img.shields.io/badge/Material_3-757575?logo=material-design) | Sistema de diseño | Latest |

---

## 📁 Estructura del proyecto

```
lib/
├── main.dart                  # Punto de entrada
├── app.dart                   # Configuración y rutas
├── models/                    # Modelos de datos
│   ├── todo_item.dart
│   ├── swimming_session.dart
│   └── user_settings.dart
├── providers/                 # Gestión de estado
│   ├── todo_provider.dart
│   └── session_provider.dart
├── pages/                     # Pantallas
│   ├── splash_screen.dart
│   ├── home_page.dart
│   ├── todo_page.dart
│   ├── sessions_page.dart
│   ├── charts_page.dart
│   └── export_page.dart
├── widgets/                   # Widgets reutilizables
│   └── todo_item_widget.dart
└── services/                  # Servicios
    └── storage_service.dart   # Persistencia con Hive
```

---

## 🎯 Roadmap

- [ ] **iOS Support**: Soporte para iPhone/iPad
- [ ] **Sincronización en la nube**: Firebase opcional
- [ ] **Notificaciones**: Recordatorios personalizables
- [ ] **Temas personalizados**: Más opciones de color
- [ ] **Widget de pantalla**: Ver estadísticas sin abrir la app
- [ ] **Compartir logros**: Integración con redes sociales
- [ ] **Multi-idioma**: Inglés, francés, portugués
- [ ] **Tipos de sesión**: Categorizar entrenamientos

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor lee nuestra [Guía de Contribución](CONTRIBUTING.md) antes de empezar.

**Formas de contribuir:**
- 🐛 Reportar bugs en [Issues](../../issues)
- 💡 Proponer nuevas funcionalidades
- 🔧 Enviar Pull Requests
- 📚 Mejorar la documentación
- 🌍 Ayudar con traducciones

### Proceso rápido

1. **Fork** el proyecto
2. Crea una **rama** para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** tus cambios (`git commit -m 'feat: add AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. Abre un **Pull Request**

### Documentación útil

- 📖 [Guía de Contribución](CONTRIBUTING.md)
- ❓ [FAQ - Preguntas Frecuentes](FAQ.md)
- 🔒 [Política de Seguridad](SECURITY.md)
- 📝 [Changelog](CHANGELOG.md)

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

## 👨‍💻 Autor

**[Tu Nombre]**
- GitHub: [@TU_USUARIO](https://github.com/TU_USUARIO)
- Email: tu@email.com

---

## 🙏 Agradecimientos

- 🎨 Iconos por [Material Design](https://material.io/design)
- 📊 Gráficas por [fl_chart](https://pub.dev/packages/fl_chart)
- 💾 Persistencia por [Hive](https://pub.dev/packages/hive)
- 🏊 Inspiración en la comunidad de natación
- ❤️ Construido con pasión usando Flutter

---

## 📚 Recursos Adicionales

- 📖 [Documentación completa](docs/)
- ❓ [Preguntas Frecuentes](FAQ.md)
- 🔒 [Seguridad y Privacidad](SECURITY.md)
- 📝 [Historial de Cambios](CHANGELOG.md)
- 🤝 [Cómo Contribuir](CONTRIBUTING.md)
- 🛠️ [Script de Desarrollo](scripts/dev.ps1)

---

<div align="center">

**Si te gusta este proyecto, dale una ⭐ en GitHub!**

[![Forks](https://img.shields.io/github/forks/TU_USUARIO/piscinapp?style=social)](../../network/members)
[![Stars](https://img.shields.io/github/stars/TU_USUARIO/piscinapp?style=social)](../../stargazers)

</div>

---

## ⭐ Dale una estrella

Si este proyecto te resultó útil, considera darle una ⭐ en GitHub. ¡Ayuda a que más personas lo descubran!

---

<div align="center">

**¡Disfruta nadando con Piscinapp! 🏊‍♂️**

[⬆ Volver arriba](#-piscinapp)

</div>
