#!/bin/bash

if pgrep -f "kitty --title fly_is_wifi"; then
    pkill -f "kitty --title fly_is_wifi"
else
    # -o window_padding_width=25  -> Le da aire alrededor (se ve mucho mejor)
    # -o background_opacity=0.85  -> Le da un toque moderno semi-transparente
    # -o font_size=12             -> Puedes ajustar el tamaño si se ve muy denso
    kitty --title fly_is_wifi \
          -o window_padding_width=25 \
          -o background_opacity=0.85 \
          -e nmtui
fi
