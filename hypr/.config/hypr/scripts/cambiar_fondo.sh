#!/bin/bash

# Directorio donde guardas tus fondos de pantalla
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Asegurar que el directorio existe
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "Error" "No se encontró el directorio $WALLPAPER_DIR"
  exit 1
fi

# Buscar todas las imágenes y pasárselas a Rofi para elegir una visualmente
CHOICE=$(ls "$WALLPAPER_DIR" | grep -E '\.(jpg|jpeg|png|webp)$' | rofi -dmenu -p "󰸉 Selecciona Wallpaper")

# Si el usuario cierra el menú sin elegir nada, salimos en paz
if [ -z "$CHOICE" ]; then
  exit 0
fi

# Ruta completa del archivo seleccionado
SELECTED_WALLPAPER="$WALLPAPER_DIR/$CHOICE"

awww img "$SELECTED_WALLPAPER" \
  --transition-type "wipe" \
  --transition-fps 60 \
  --transition-duration 1.0

# 2. Ejecutar Matugen de forma automática sin preguntar por colores en la terminal
matugen image "$SELECTED_WALLPAPER" --prefer saturation

# Forzar a Waybar a apagar y encender con los nuevos estilos aplicados
killall waybar
sleep 0.1
waybar &
disown

# -> AÑADE ESTA LÍNEA AQUÍ:
# Avisar a todas las instancias abiertas de Neovim que recarguen el tema en caliente
pkill -USR1 nvim 2>/dev/null || true

# 3. Notificación estética
notify-send -u low -i "$SELECTED_WALLPAPER" "Tema Actualizado" "Paleta generada a partir de $CHOICE"
