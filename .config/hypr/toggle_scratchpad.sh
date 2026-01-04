#!/bin/bash

APP_CLASS="scratchpad_term"

# 1. Comprobamos si la ventana YA existe
if hyprctl clients | grep -q "class: $APP_CLASS"; then
    # Si existe, solo mostramos/ocultamos el espacio especial
    hyprctl dispatch togglespecialworkspace scratch
else
    # 2. Si NO existe:
    # A) La creamos en el escritorio ACTUAL (No en special).
    #    Al usar 'stayfocused', aseguramos que sea la ventana activa para los siguientes comandos.
    hyprctl dispatch exec "[float;size 80% 70%;center;stayfocused] kitty --class $APP_CLASS"

    # B) Esperamos un instante minúsculo a que la ventana aparezca y tome el foco
    sleep 0.1

    # C) La enviamos al Special Workspace (se llevará su tamaño y estado flotante con ella)
    hyprctl dispatch movetoworkspace special:scratch

    # D) (Opcional) Aseguramos que el Special Workspace sea visible
    #    (A veces movetoworkspace lo oculta, esto lo trae al frente)
    hyprctl dispatch togglespecialworkspace scratch
fi
