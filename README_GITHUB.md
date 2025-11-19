# 🏊‍♂️ Piscina TODO App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-Ready-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completo-success?style=for-the-badge)

**Aplicación Flutter completa para gestionar tu preparación de piscina y registrar tus sesiones de natación**

[Características](#-características) • [Instalación](#-instalación) • [Uso](#-cómo-usar) • [Tecnologías](#-tecnologías)

</div>

---

## 📱 Características

### 📝 Lista TODO Inteligente
- ✅ Gestiona tu equipamiento de piscina
- ✅ Marca ítems completados
- 📌 **Función Chincheta**: Guarda tu lista base permanentemente
- 🔄 La lista base se carga automáticamente al abrir la app

### 🏊 Registro de Sesiones
- 📊 Registra cuántas piscinas has hecho
- 📅 Selecciona la fecha de cada sesión
- 🔢 Conversión automática: **piscinas × 25 = metros**
- 💾 Historial completo de todas tus sesiones

### 📈 Estadísticas Visuales
- 📊 Gráfica de barras interactiva con tus progresos
- 📉 Visualiza piscinas por fecha
- 📋 Resumen de totales: sesiones, piscinas, metros
- 🎯 Promedio de piscinas por sesión

---

## 🚀 Instalación

### Requisitos previos
- Flutter SDK (3.0+)
- Android Studio / VS Code
- Dispositivo Android o emulador

### Pasos

1. **Clonar el repositorio**
```bash
git clone <tu-repo>
cd piscina_todo_app
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Generar adaptadores de Hive**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Ejecutar la app**
```bash
flutter run
```

---

## 🎮 Cómo usar

### Pantalla 1: Preparar la piscina
1. Añade ítems a tu lista (gafas, gorro, bañador, etc.)
2. Marca los que ya tienes listos
3. Presiona la **chincheta 📌** para guardar tu lista base
4. La próxima vez que abras la app, tu lista estará lista para usar

### Pantalla 2: Registrar sesión
1. Ingresa cuántas piscinas hiciste
2. Selecciona la fecha
3. Guarda la sesión
4. ¡Verás automáticamente los metros nadados!

### Pantalla 3: Ver estadísticas
1. Observa tu gráfica de progreso
2. Revisa tus totales y promedios
3. Toca las barras para ver detalles

---

## 🛠 Tecnologías

| Tecnología | Uso |
|------------|-----|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white) | Framework principal |
| ![Provider](https://img.shields.io/badge/Provider-EE4C2C?logo=flutter&logoColor=white) | Gestión de estado |
| ![Hive](https://img.shields.io/badge/Hive-FFA000?logo=hive&logoColor=white) | Base de datos local |
| ![fl_chart](https://img.shields.io/badge/fl__chart-4CAF50?logo=chartdotjs&logoColor=white) | Gráficas |
| ![Material 3](https://img.shields.io/badge/Material_3-757575?logo=material-design&logoColor=white) | Diseño UI |

---

## 📂 Estructura del proyecto

```
lib/
├── main.dart              # Punto de entrada
├── app.dart               # Configuración y navegación
├── models/                # Modelos de datos
├── providers/             # Gestión de estado
├── pages/                 # Pantallas de la app
├── widgets/               # Widgets reutilizables
└── services/              # Servicios (persistencia)
```

---

## ✨ Características destacadas

### 🔒 Persistencia total
Todo se guarda automáticamente. Sin preocupaciones por perder datos.

### 📌 Función Chincheta única
Guarda tu lista perfecta y úsala siempre que vayas a la piscina.

### 🎨 Diseño moderno
Material Design 3 con tema adaptable al sistema.

### ⚡ Rendimiento
Base de datos NoSQL local (Hive) para velocidad máxima.

---

## 🔨 Compilar para producción

### APK de producción
```bash
flutter build apk --release
```

El APK estará en: `build/app/outputs/flutter-apk/app-release.apk`

### APK optimizado por arquitectura
```bash
flutter build apk --split-per-abi --release
```

---

## 📝 Comandos útiles

```bash
# Ejecutar en modo desarrollo
flutter run

# Ejecutar en modo release (más rápido)
flutter run --release

# Ver dispositivos conectados
flutter devices

# Analizar código
flutter analyze

# Limpiar proyecto
flutter clean
```

---

## 🐛 Solución de problemas

### Error de compilación
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Problemas con Hive
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de usarlo y modificarlo.

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea tu rama (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 👨‍💻 Autor

Creado con ❤️ usando Flutter

---

## 🌟 ¿Te gusta el proyecto?

Si te resulta útil, ¡dale una estrella ⭐ al repositorio!

---

<div align="center">

**¡Disfruta nadando! 🏊‍♂️**

</div>
