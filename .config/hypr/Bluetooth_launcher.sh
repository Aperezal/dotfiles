#!/bin/bash
# Verificamos si ya está corriendo para no abrirlo dos veces
if pgrep -f "kitty --title fly_is_bluetooth"; then
    pkill -f "kitty --title fly_is_bluetooth"
else
    # Lanzamos kitty con el título específico
    kitty --title fly_is_bluetooth -e bluetuith
fi
