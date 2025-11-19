from PIL import Image, ImageDraw
import os

# Crear directorio si no existe
os.makedirs('assets/icon', exist_ok=True)

# Crear imagen de 1024x1024
size = 1024
img = Image.new('RGB', (size, size), color='#0288D1')
draw = ImageDraw.Draw(img)

# Ondas de agua (fondo)
draw.ellipse([0, 600, size, 900], fill='#01579B', outline=None)
draw.ellipse([0, 700, size, 1000], fill='#0277BD', outline=None)

# Cabeza del nadador
head_x, head_y = 520, 360
head_radius = 80
draw.ellipse([head_x-head_radius, head_y-head_radius, 
              head_x+head_radius, head_y+head_radius], 
             fill='white', outline=None)

# Gafas (línea oscura horizontal)
draw.ellipse([head_x-70, head_y-10, head_x+70, head_y+15], 
             fill='#263238', outline=None)

# Cuerpo
body_x, body_y = 440, 480
draw.ellipse([body_x-160, body_y-70, body_x+160, body_y+70], 
             fill='white', outline=None)

# Brazo extendido (izquierda)
draw.ellipse([240, 360, 400, 420], fill='white', outline=None)

# Brazo en agua (derecha, semi-transparente)
draw.ellipse([560, 460, 720, 520], fill='#B3E5FC', outline=None)

# Piernas
draw.ellipse([340, 520, 500, 580], fill='#B3E5FC', outline=None)

# Salpicaduras (círculos blancos pequeños)
splash_positions = [(230, 350), (200, 380), (260, 340), (730, 480), (760, 500)]
for x, y in splash_positions:
    r = 15
    draw.ellipse([x-r, y-r, x+r, y+r], fill='white', outline=None)

# Guardar como app_icon.png
img.save('assets/icon/app_icon.png')
print("✓ Creado: assets/icon/app_icon.png")

# Crear versión foreground (sin fondo azul, solo nadador)
img_fg = Image.new('RGBA', (size, size), color=(0, 0, 0, 0))
draw_fg = ImageDraw.Draw(img_fg)

# Cabeza del nadador
draw_fg.ellipse([head_x-head_radius, head_y-head_radius, 
                 head_x+head_radius, head_y+head_radius], 
                fill='white', outline=None)

# Gafas
draw_fg.ellipse([head_x-70, head_y-10, head_x+70, head_y+15], 
                fill='#263238', outline=None)

# Cuerpo
draw_fg.ellipse([body_x-160, body_y-70, body_x+160, body_y+70], 
                fill='white', outline=None)

# Brazo extendido
draw_fg.ellipse([240, 360, 400, 420], fill='white', outline=None)

# Brazo en agua
draw_fg.ellipse([560, 460, 720, 520], fill='#90CAF9', outline=None)

# Piernas
draw_fg.ellipse([340, 520, 500, 580], fill='#90CAF9', outline=None)

# Salpicaduras
for x, y in splash_positions:
    r = 15
    draw_fg.ellipse([x-r, y-r, x+r, y+r], fill='white', outline=None)

# Guardar como app_icon_foreground.png
img_fg.save('assets/icon/app_icon_foreground.png')
print("✓ Creado: assets/icon/app_icon_foreground.png")

print("\n¡Iconos creados exitosamente!")
print("Ahora ejecuta: flutter pub run flutter_launcher_icons")
