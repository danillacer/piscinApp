# 🚀 Comandos Útiles - Piscinapp

Referencia rápida de comandos para desarrollo de Piscinapp.

---

## 📦 Instalación y Configuración

### Primera vez
```bash
# Clonar repositorio
git clone https://github.com/TU_USUARIO/piscinapp.git
cd piscinapp

# Instalar dependencias
flutter pub get

# Generar código Hive
flutter pub run build_runner build --delete-conflicting-outputs

# Verificar configuración
flutter doctor
```

### Actualizar dependencias
```bash
# Ver dependencias desactualizadas
flutter pub outdated

# Actualizar todas
flutter pub upgrade

# Obtener dependencias actuales
flutter pub get
```

---

## 🛠 Desarrollo

### Ejecutar la app
```bash
# Debug mode (desarrollo)
flutter run

# En dispositivo específico
flutter devices
flutter run -d <device-id>

# Con hot reload activo (presiona 'r' en la terminal)
# Con hot restart (presiona 'R' en la terminal)
```

### Generar código
```bash
# Generar Hive adapters
flutter pub run build_runner build

# Regenerar eliminando conflictos
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (regenera automáticamente)
flutter pub run build_runner watch
```

### Análisis y formato
```bash
# Analizar código
flutter analyze

# Formatear código
flutter format .

# Formatear archivo específico
flutter format lib/pages/home_page.dart

# Ver qué se formateará sin aplicar cambios
flutter format --dry-run .
```

---

## 🔨 Compilación

### Debug (desarrollo)
```bash
# APK debug
flutter build apk --debug

# App Bundle debug
flutter build appbundle --debug
```

### Release (producción)
```bash
# APK release
flutter build apk --release

# APK split por ABI (reduce tamaño)
flutter build apk --split-per-abi --release

# App Bundle (para Play Store)
flutter build appbundle --release

# Con ofuscación de código
flutter build apk --release --obfuscate --split-debug-info=./debug-info
```

### Ver tamaño del build
```bash
# Analizar tamaño del APK
flutter build apk --analyze-size

# Ver árbol de tamaños
flutter build apk --tree-shake-icons --analyze-size
```

---

## 🧪 Testing

### Ejecutar tests
```bash
# Todos los tests
flutter test

# Test específico
flutter test test/models/todo_item_test.dart

# Con coverage
flutter test --coverage

# Ver reporte de coverage (requiere lcov)
genhtml coverage/lcov.info -o coverage/html
```

### Tests de integración
```bash
# Ejecutar integration tests
flutter test integration_test/app_test.dart

# En dispositivo específico
flutter test integration_test/app_test.dart -d <device-id>
```

---

## 🧹 Limpieza

### Limpiar proyecto
```bash
# Limpieza básica
flutter clean

# Limpiar + reinstalar dependencias
flutter clean
flutter pub get

# Limpiar código generado
rm -rf lib/**/*.g.dart
flutter pub run build_runner build --delete-conflicting-outputs

# Limpiar build de Android
cd android
.\gradlew clean
cd ..
```

### Limpiar caché
```bash
# Limpiar caché de pub
flutter pub cache repair

# Eliminar cache de Flutter
flutter clean
rm -rf $HOME/.pub-cache
```

---

## 📱 Dispositivos y Emuladores

### Gestión de dispositivos
```bash
# Listar dispositivos conectados
flutter devices

# Listar emuladores disponibles
flutter emulators

# Ejecutar emulador
flutter emulators --launch <emulator-id>

# Información de dispositivos
adb devices
```

### Logs y debug
```bash
# Ver logs en tiempo real
flutter logs

# Logs de Android específicamente
adb logcat

# Limpiar logs
adb logcat -c

# Filtrar logs de la app
adb logcat | grep "flutter"
```

---

## 📦 Gestión de Assets

### Iconos
```bash
# Generar iconos de la app (si usas flutter_launcher_icons)
flutter pub run flutter_launcher_icons:main

# Script Python custom
python create_icons.py
```

### Assets
```bash
# Verificar que assets estén en pubspec.yaml
# Ejecutar después de añadir nuevos assets:
flutter clean
flutter pub get
flutter run
```

---

## 🗄 Base de Datos (Hive)

### Inspeccionar datos
```bash
# Ubicación de datos en Android
adb shell "ls -la /data/data/com.example.piscina_todo_app/app_flutter/"

# Descargar base de datos
adb pull /data/data/com.example.piscina_todo_app/app_flutter/ ./hive_backup/

# Limpiar datos de la app (resetear)
adb shell pm clear com.example.piscina_todo_app
```

---

## 🔧 Git

### Flujo básico
```bash
# Clonar
git clone <url>

# Estado
git status

# Añadir cambios
git add .

# Commit
git commit -m "feat: descripción del cambio"

# Push
git push origin main

# Pull
git pull origin main
```

### Branches
```bash
# Crear branch
git checkout -b feature/nueva-funcionalidad

# Cambiar de branch
git checkout main

# Listar branches
git branch -a

# Eliminar branch
git branch -d feature/vieja-funcionalidad
```

### Tags (releases)
```bash
# Crear tag
git tag -a v1.0.0 -m "Release v1.0.0"

# Push tags
git push origin --tags

# Listar tags
git tag -l
```

---

## 📊 Performance

### Profiling
```bash
# Profile mode
flutter run --profile

# Observar rendimiento
flutter run --profile --trace-skia

# DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

### Análisis de tamaño
```bash
# Ver qué ocupa espacio en el APK
flutter build apk --analyze-size --target-platform android-arm64
```

---

## 🌐 Web (si aplica en el futuro)

```bash
# Ejecutar en web
flutter run -d chrome

# Build para web
flutter build web

# Con optimizaciones
flutter build web --release --web-renderer canvaskit
```

---

## 🔄 Script PowerShell (Atajo)

```powershell
# Usar el script de utilidades
.\scripts\dev.ps1 setup      # Configurar proyecto
.\scripts\dev.ps1 run        # Ejecutar app
.\scripts\dev.ps1 build      # Build release
.\scripts\dev.ps1 analyze    # Analizar
.\scripts\dev.ps1 format     # Formatear
.\scripts\dev.ps1 generate   # Generar código
.\scripts\dev.ps1 clean      # Limpiar
.\scripts\dev.ps1 check      # Verificación completa
```

---

## 📝 Conventional Commits

```bash
# Formato
<tipo>(<scope>): <descripción>

# Tipos
feat:       Nueva funcionalidad
fix:        Corrección de bug
docs:       Documentación
style:      Formato (no afecta código)
refactor:   Refactorización
perf:       Mejora de performance
test:       Tests
chore:      Tareas de mantenimiento

# Ejemplos
git commit -m "feat(todo): agregar drag and drop"
git commit -m "fix(sessions): corregir cálculo de racha"
git commit -m "docs(readme): actualizar capturas"
```

---

## 🆘 Troubleshooting

### App no compila
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Problemas con Gradle
```bash
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
```

### Hot reload no funciona
```bash
# Usar Hot Restart (R)
# O reiniciar completamente:
flutter run
```

### Dependencias rotas
```bash
flutter pub cache repair
flutter clean
flutter pub get
```

---

## 📚 Recursos

- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Docs](https://dart.dev/guides)
- [Hive Docs](https://docs.hivedb.dev/)
- [Material Design](https://material.io/design)
- [Pub.dev](https://pub.dev/)

---

**Tip**: Crea alias en tu shell para comandos frecuentes:
```powershell
# En PowerShell profile ($PROFILE)
function frun { flutter run }
function fbuild { flutter build apk --release }
function fgen { flutter pub run build_runner build --delete-conflicting-outputs }
```

---

_Última actualización: 19 de noviembre de 2025_
