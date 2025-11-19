# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir a **Piscinapp**! 🎉

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo puedo contribuir?](#cómo-puedo-contribuir)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Guía de Estilo](#guía-de-estilo)
- [Commits](#commits)
- [Pull Requests](#pull-requests)

---

## 📜 Código de Conducta

Este proyecto se adhiere a un código de conducta de contribución. Al participar, se espera que mantengas un ambiente respetuoso y constructivo.

### Comportamiento esperado:
- ✅ Ser respetuoso y profesional
- ✅ Aceptar críticas constructivas
- ✅ Enfocarse en lo mejor para la comunidad
- ✅ Mostrar empatía hacia otros miembros

### Comportamiento NO aceptado:
- ❌ Lenguaje o imágenes inapropiadas
- ❌ Ataques personales o insultos
- ❌ Acoso público o privado
- ❌ Publicar información privada de terceros

---

## 🛠 ¿Cómo puedo contribuir?

### 🐛 Reportar Bugs

Si encuentras un error, por favor:

1. **Verifica** que no esté ya reportado en [Issues](../../issues)
2. **Crea un nuevo Issue** con:
   - Título descriptivo y claro
   - Pasos para reproducir el error
   - Comportamiento esperado vs actual
   - Capturas de pantalla (si aplica)
   - Versión de Flutter/Dart
   - Sistema operativo

**Plantilla de Bug Report:**
```markdown
**Descripción del bug**
[Descripción clara y concisa]

**Pasos para reproducir**
1. Ve a '...'
2. Haz clic en '...'
3. Observa el error

**Comportamiento esperado**
[Qué debería suceder]

**Capturas de pantalla**
[Si aplica]

**Entorno**
- Flutter: [version]
- Dart: [version]
- SO: [Android/iOS version]
```

---

### 💡 Sugerir Funcionalidades

Para proponer nuevas características:

1. **Revisa** las Issues existentes para evitar duplicados
2. **Crea un Issue** con la etiqueta `enhancement`
3. **Describe** claramente:
   - Problema que resuelve
   - Solución propuesta
   - Alternativas consideradas
   - Impacto en el proyecto

---

### 🔧 Contribuir con Código

1. **Fork** el repositorio
2. **Crea una rama** desde `main`:
   ```bash
   git checkout -b feature/nueva-funcionalidad
   # o
   git checkout -b fix/correccion-bug
   ```
3. **Implementa** tus cambios
4. **Prueba** exhaustivamente
5. **Commit** siguiendo las convenciones
6. **Push** a tu fork
7. **Abre un Pull Request**

---

## 🚀 Proceso de Desarrollo

### 1️⃣ Configuración del Entorno

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/piscinapp.git
cd piscinapp

# Instalar dependencias
flutter pub get

# Generar código (Hive adapters)
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar la app
flutter run
```

### 2️⃣ Estructura del Proyecto

```
lib/
├── models/          # Modelos de datos (Hive)
├── providers/       # Estado (Provider)
├── pages/           # Pantallas de la app
├── widgets/         # Widgets reutilizables
├── services/        # Servicios (Storage)
├── app.dart         # Configuración de rutas
└── main.dart        # Punto de entrada
```

### 3️⃣ Testing

```bash
# Ejecutar tests (cuando estén disponibles)
flutter test

# Análisis de código
flutter analyze

# Formatear código
flutter format .
```

---

## 🎨 Guía de Estilo

### Dart/Flutter

Sigue las convenciones de [Effective Dart](https://dart.dev/guides/language/effective-dart):

- **Nombres de clases**: `PascalCase`
- **Variables/funciones**: `camelCase`
- **Constantes**: `lowerCamelCase` (o `UPPER_CASE` si son top-level)
- **Archivos**: `snake_case.dart`
- **Privados**: prefijo `_`

**Ejemplo:**
```dart
class TodoItemWidget extends StatefulWidget {
  final TodoItem item;
  final VoidCallback onToggle;
  
  const TodoItemWidget({
    Key? key,
    required this.item,
    required this.onToggle,
  }) : super(key: key);
  
  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}
```

### Widgets

- Usa `const` constructors siempre que sea posible
- Separa widgets grandes en componentes más pequeños
- Extrae lógica compleja a métodos privados

### Comentarios

```dart
// Comentarios de una línea para explicaciones breves

/// Documentación con triple slash para clases/métodos públicos
/// 
/// [item] es el elemento a mostrar
/// [onToggle] se ejecuta al marcar/desmarcar
void toggleItem(TodoItem item, VoidCallback onToggle) {
  // Implementación
}
```

---

## 📝 Commits

Usa **[Conventional Commits](https://www.conventionalcommits.org/)**:

### Formato
```
<tipo>(<scope>): <descripción>

[cuerpo opcional]

[footer opcional]
```

### Tipos permitidos:
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Cambios en documentación
- `style`: Formato, punto y coma, etc (no afecta código)
- `refactor`: Refactorización sin cambios funcionales
- `perf`: Mejoras de rendimiento
- `test`: Añadir o corregir tests
- `chore`: Tareas de mantenimiento

### Ejemplos:
```bash
git commit -m "feat(todo): agregar drag and drop para reordenar items"
git commit -m "fix(sessions): corregir cálculo de racha cuando faltan días"
git commit -m "docs(readme): actualizar capturas de pantalla"
git commit -m "refactor(providers): extraer lógica de streak a UserSettings"
```

---

## 🔀 Pull Requests

### Antes de crear un PR:

- ✅ Asegúrate que `flutter analyze` no muestre errores
- ✅ Verifica que la app compila: `flutter build apk`
- ✅ Prueba en dispositivo/emulador
- ✅ Actualiza documentación si es necesario

### Plantilla de PR:

```markdown
## Descripción
[Describe tus cambios]

## Tipo de cambio
- [ ] 🐛 Bug fix
- [ ] ✨ Nueva funcionalidad
- [ ] 💥 Breaking change
- [ ] 📚 Documentación

## ¿Cómo se ha probado?
[Describe las pruebas realizadas]

## Checklist
- [ ] Mi código sigue el estilo del proyecto
- [ ] He realizado una auto-revisión
- [ ] He comentado código complejo
- [ ] He actualizado la documentación
- [ ] Mis cambios no generan warnings
- [ ] He probado en dispositivo real
```

### Proceso de Revisión:

1. Un maintainer revisará tu PR
2. Pueden solicitarse cambios
3. Una vez aprobado, se hará merge
4. Tu contribución aparecerá en el CHANGELOG

---

## 🏆 Reconocimientos

Todos los contribuidores serán reconocidos en el README y releases notes.

---

## ❓ Preguntas

Si tienes dudas, puedes:
- 📧 Abrir un Issue con la etiqueta `question`
- 💬 Comentar en Discussions (si están habilitadas)

---

**¡Gracias por contribuir a Piscinapp!** 🏊‍♂️💙
