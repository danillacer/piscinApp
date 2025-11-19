# ❓ Preguntas Frecuentes (FAQ)

## 📱 General

### ¿Qué es Piscinapp?
Piscinapp es una aplicación móvil diseñada para nadadores que desean organizar su preparación antes de ir a la piscina y llevar un registro detallado de sus sesiones de natación con estadísticas visuales.

### ¿Es gratuita?
Sí, Piscinapp es **100% gratuita** y de código abierto (MIT License).

### ¿Necesito conexión a Internet?
**No**. Piscinapp funciona completamente offline. Todos tus datos se almacenan localmente en tu dispositivo.

### ¿En qué plataformas está disponible?
- ✅ **Android**: Disponible
- ⏳ **iOS**: En desarrollo/pendiente
- ❌ **Web**: No planeado actualmente

---

## 🔧 Instalación y Uso

### ¿Cómo instalo la app?
1. Descarga el APK desde [GitHub Releases](../../releases)
2. Habilita "Instalar apps de origen desconocido" en Android
3. Instala el APK

**O compílala tú mismo:**
```bash
git clone https://github.com/tu-usuario/piscinapp.git
cd piscinapp
flutter pub get
flutter build apk --release
```

### ¿Por qué no está en Google Play Store?
Actualmente es un proyecto personal/educativo. Subir a Play Store requiere:
- Pago de cuenta de desarrollador ($25 USD)
- Cumplir políticas de privacidad/permisos
- Mantenimiento continuo

Podría considerarse en el futuro si hay suficiente interés.

---

## 📝 Lista TODO

### ¿Para qué sirve la lista TODO?
Te permite crear una checklist personalizada de cosas que necesitas llevar a la piscina (gafas, gorro, bañador, etc.). Puedes marcar los ítems a medida que los preparas.

### ¿Cómo funciona la chincheta (📌)?
Al presionar el ícono de chincheta en la lista TODO, guardas la lista actual como "plantilla base". Cada vez que marques todos los ítems, podrás restaurar rápidamente esta lista base.

### ¿Puedo editar un ítem?
Sí, **haz doble clic** sobre el nombre del ítem para editarlo directamente.

### ¿Cómo reordeno los ítems?
**Arrastra** usando el ícono de las 6 líneas (⋮⋮) al lado derecho de cada ítem.

---

## 🏊 Sesiones

### ¿Qué son las "piscinas"?
Una "piscina" equivale a **25 metros** (longitud estándar de piscina). Si nadas 40 piscinas, la app calculará automáticamente 1000 metros.

### ¿Puedo cambiar la longitud de la piscina?
En la versión actual, está fijo a 25m. Esta funcionalidad podría añadirse en el futuro.

### ¿Cómo registro una sesión pasada?
Al añadir una sesión, presiona el ícono de calendario para seleccionar una fecha anterior.

### ¿Puedo editar o eliminar una sesión?
- **Editar**: No disponible aún (próxima versión)
- **Eliminar**: Sí, desliza o presiona el ícono de eliminar en la sesión

---

## 📊 Estadísticas

### ¿Qué es la "racha"?
La racha cuenta cuántos **días consecutivos** has nadado. Si dejas de nadar un día, la racha se reinicia.

### ¿Cómo se calcula el progreso semanal?
Suma todas las piscinas nadadas desde el lunes de la semana actual hasta hoy, comparándolas con tu objetivo semanal.

### ¿Puedo cambiar mi objetivo semanal?
Sí, en la pantalla de inicio (home), presiona el ícono de edición (✏️) en la tarjeta de "Objetivo Semanal".

### ¿Qué muestran las gráficas?
- **Gráfica de barras**: Piscinas nadadas por fecha (últimas sesiones)
- **Gráfica de línea**: Progreso acumulado total de piscinas

---

## 💾 Datos y Exportación

### ¿Dónde se guardan mis datos?
Todos los datos se almacenan **localmente** en tu dispositivo usando Hive (base de datos NoSQL). Nadie más tiene acceso a ellos.

### ¿Puedo hacer backup de mis datos?
Sí, en la sección "Exportar" puedes:
- Exportar sesiones a CSV
- Exportar lista TODO a CSV

Los archivos se guardan en `/storage/emulated/0/Documents/` con timestamp.

### ¿Puedo importar datos?
No en la versión actual. Está planeado para futuras versiones.

### ¿Pierdo mis datos si desinstalo la app?
**Sí**. Al desinstalar la app, Android elimina todos los datos de la app. Exporta tus datos antes de desinstalar.

---

## 🐛 Problemas Comunes

### La app no abre / se cierra al iniciar
1. Desinstala la app
2. Reinicia el dispositivo
3. Vuelve a instalar
4. Si persiste, reporta el bug en [Issues](../../issues)

### No puedo añadir sesiones
Verifica que:
- Estés ingresando un número válido de piscinas
- La fecha seleccionada sea válida

### Las gráficas no se muestran
- Asegúrate de tener al menos **2 sesiones** registradas
- Reinicia la app
- Si persiste, reporta el problema

### La racha no se actualiza
La racha se calcula al agregar una nueva sesión. Si nadaste ayer y hoy, deberías ver racha de 2 días.

---

## 🚀 Futuras Funcionalidades

### ¿Qué viene próximamente?
Puedes ver el roadmap completo en [README.md](README_PROYECTO.md#-roadmap), pero destacan:
- 🔔 Notificaciones de recordatorio
- 📱 Widget de pantalla de inicio
- ☁️ Sincronización en la nube (opcional)
- 🌙 Modo oscuro
- 📥 Importar desde CSV

### ¿Cómo puedo solicitar una funcionalidad?
Abre un [Issue](../../issues/new) con la etiqueta `enhancement` y describe tu idea.

---

## 🤝 Contribución

### ¿Puedo contribuir al proyecto?
¡Por supuesto! Lee la [Guía de Contribución](CONTRIBUTING.md) para empezar.

### No sé programar, ¿cómo puedo ayudar?
Puedes:
- Reportar bugs
- Sugerir mejoras
- Compartir la app
- Traducir a otros idiomas (futuro)
- Mejorar la documentación

---

## 📧 Contacto

### ¿Dónde puedo obtener soporte?
- 🐛 **Bugs**: [GitHub Issues](../../issues)
- 💡 **Ideas**: [GitHub Issues](../../issues) con etiqueta `enhancement`
- 💬 **Preguntas**: [GitHub Discussions](../../discussions) (si está habilitado)

---

**¿Tu pregunta no está aquí?** Abre un issue con la etiqueta `question` y la añadiremos.

---

**Última actualización**: 19 de noviembre de 2025
