#!/bin/bash

# 1. Matar instancias viejas para asegurar limpieza
killall hyprpaper
sleep 1

# 2. Iniciar hyprpaper en segundo plano
hyprpaper &

# 3. Esperar a que arranque
sleep 1

# 4. Enviar las órdenes manuales que SÍ funcionan
hyprctl hyprpaper preload "/home/apereza/Downloads/earth2.jpg"
hyprctl hyprpaper wallpaper ",/home/apereza/Downloads/earth2.jpg"
