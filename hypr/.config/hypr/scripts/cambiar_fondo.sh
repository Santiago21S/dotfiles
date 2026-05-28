#!/bin/bash

# Directorio donde guardas tus fondos de pantalla
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Asegurar que el directorio existe
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "Error" "No se encontró el directorio $WALLPAPER_DIR"
  exit 1
fi

# 1. Construimos el formato especial de Wofi y le pedimos imágenes grandes (ej. 150px)
CHOICE_RAW=$(ls "$WALLPAPER_DIR" | grep -E '\.(jpg|jpeg|png|webp)$' | while read -r img; do
  echo "img:$WALLPAPER_DIR/$img:text:$img"
done | wofi --show dmenu -i -p "󰸉 Selecciona Wallpaper" --image-size=150)

# 2. Si el usuario cierra el menú sin elegir nada, salimos en paz
if [ -z "$CHOICE_RAW" ]; then
  exit 0
fi

# 3. Limpiamos la cadena (ej: "img:/ruta/foto.jpg:text:foto.jpg") para extraer solo el nombre final
CHOICE=$(echo "$CHOICE_RAW" | awk -F'text:' '{print $2}')

# Ruta completa del archivo seleccionado
SELECTED_WALLPAPER="$WALLPAPER_DIR/$CHOICE"

# Crear o actualizar un enlace simbólico fijo para que Hyprlock lo use siempre
ln -sf "$SELECTED_WALLPAPER" "$HOME/.config/hypr/actual_wallpaper.png"

awww img "$SELECTED_WALLPAPER" \
  --transition-type "wipe" \
  --transition-fps 60 \
  --transition-duration 1.0

# Ejecutar Matugen de forma automática sin preguntar por colores en la terminal
matugen image "$SELECTED_WALLPAPER" --prefer saturation

# Forzar a Waybar a apagar y encender con los nuevos estilos aplicados
killall waybar
sleep 0.1
waybar &
disown

# Avisar a todas las instancias abiertas de Neovim que recarguen el tema en caliente
pkill -USR1 nvim 2>/dev/null || true

# Notificación estética
notify-send -u low -i "$SELECTED_WALLPAPER" "Tema Actualizado" "Paleta generada a partir de $CHOICE"
