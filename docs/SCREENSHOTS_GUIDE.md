# 📸 Guía para tomar screenshots de Piscinapp

Este archivo contiene instrucciones para crear las capturas de pantalla necesarias para el README.

## 🎯 Capturas necesarias

### 1. **home.png** - Pantalla de Inicio
**Ruta**: `docs/screenshots/home.png`

**Preparación**:
- Ejecuta la app después del splash screen
- Asegúrate de tener:
  - Al menos 1 ítem en la lista TODO
  - Al menos 3 sesiones registradas
  - Racha actual > 0
  - Progreso semanal visible

**Captura**: Pantalla completa mostrando las 4 tarjetas y estadísticas

---

### 2. **todo.png** - Lista TODO
**Ruta**: `docs/screenshots/todo.png`

**Preparación**:
- Navega a "Preparar"
- Añade varios ítems (Gafas, Gorro, Bañador, Toalla, etc.)
- Marca algunos como completados
- Muestra el icono de chincheta resaltado

**Captura**: Lista con varios ítems, algunos marcados

---

### 3. **sessions.png** - Registro de Sesiones
**Ruta**: `docs/screenshots/sessions.png`

**Preparación**:
- Navega a "Sesiones"
- Muestra el formulario de nueva sesión con datos
- Lista de sesiones anteriores visible debajo

**Captura**: Formulario + lista de historial

---

### 4. **stats.png** - Estadísticas
**Ruta**: `docs/screenshots/stats.png`

**Preparación**:
- Navega a "Estadísticas"
- Asegúrate de tener varias sesiones para que las gráficas se vean bien
- Scroll para mostrar gráfica de barras + tarjetas de racha/objetivo

**Captura**: Gráficas y resumen de estadísticas

---

### 5. **export.png** - Exportación
**Ruta**: `docs/screenshots/export.png`

**Preparación**:
- Navega a "Exportar"
- Muestra las dos tarjetas de exportación habilitadas

**Captura**: Pantalla de exportación completa

---

## 🛠 Herramientas recomendadas

### Opción 1: Desde el emulador/dispositivo
1. Ejecuta `flutter run`
2. En el emulador, usa el botón de screenshot
3. O presiona `Ctrl + S` en algunos emuladores

### Opción 2: Usando scrcpy (recomendado)
```bash
# Instalar scrcpy
winget install scrcpy

# Conectar dispositivo y tomar screenshot
scrcpy --window-title="Piscinapp" --max-size=1080
# Luego usa Alt + S para capturar
```

### Opción 3: ADB
```bash
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

---

## 📐 Especificaciones

- **Formato**: PNG
- **Resolución**: 1080x2400 o similar (16:9)
- **Tamaño**: < 500KB por imagen
- **Orientación**: Portrait (vertical)

---

## ✂️ Edición (opcional)

Si quieres editar las capturas:

1. **Recortar barras del sistema** (opcional)
2. **Añadir sombra** para efecto flotante
3. **Comprimir** con herramientas online:
   - https://tinypng.com/
   - https://squoosh.app/

---

## 📝 Checklist

- [ ] home.png capturado
- [ ] todo.png capturado
- [ ] sessions.png capturado
- [ ] stats.png capturado
- [ ] export.png capturado
- [ ] Todas las imágenes en `docs/screenshots/`
- [ ] Tamaños verificados (< 500KB)
- [ ] README actualizado con las rutas correctas

---

## 🎬 Alternativa: GIF animado

Si quieres crear un GIF demostrativo:

```bash
# Grabar video con scrcpy
scrcpy --record=demo.mp4

# Convertir a GIF con ffmpeg
ffmpeg -i demo.mp4 -vf "fps=10,scale=320:-1:flags=lanczos" demo.gif
```

---

**¡Listo para capturar!** 📸
