#!/usr/bin/env bash
set -e

SRC="$HOME/.config/colors/palette.env"
DEST="$HOME/.config/colors"

# Load palette
source "$SRC"

# Hyprland
cat > "$DEST/palette.conf" <<EOF
\$base00 = ${BASE00#\#}
\$base01 = ${BASE01#\#}
\$base02 = ${BASE02#\#}
\$base03 = ${BASE03#\#}

\$accent  = ${ACCENT#\#}
\$accent2 = ${ACCENT2#\#}
\$accent3 = ${ACCENT3#\#}
\$red     = ${RED#\#}
\$green   = ${GREEN#\#}
\$yellow  = ${YELLOW#\#}
EOF
# Waybar (CSS)
cat > "$DEST/palette.css" <<EOF
@define-color base00 $BASE00;
@define-color base01 $BASE01;
@define-color base02 $BASE02;
@define-color base03 $BASE03;
@define-color accent $ACCENT;
@define-color accent2 $ACCENT2;
@define-color accent3 $ACCENT3;
@define-color red $RED;
@define-color green $GREEN;
@define-color yellow $YELLOW;
EOF

# tmux
cat > "$DEST/palette.tmux" <<EOF
base00=$BASE00
base01=$BASE01
base02=$BASE02
base03=$BASE03
accent=$ACCENT
accent2=$ACCENT2
accent3=$ACCENT3
red=$RED
green=$GREEN
yellow=$YELLOW
EOF

echo "✔ Colors generated for Hyprland, Waybar, and Tmux."

