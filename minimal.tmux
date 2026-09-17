#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source the pre-built colorscheme variants and the theme file
source "$CURRENT_DIR/scripts/color-variants.sh"
source "$CURRENT_DIR/scripts/minimal-theme.sh"

# If @minimal_theme_colorscheme is set to the name of a function defined in
# color-variants.sh (e.g. "nordfox", "catppuccin_frappe"), apply all of its
# colors in one go. Individually configured @minimal_theme_* color options are
# preserved, so manual tweaks in tmux.conf always override the scheme.
apply_colorscheme() {
    local scheme
    scheme="$(tmux show-option -gqv "@minimal_theme_colorscheme")"
    [ -z "$scheme" ] && return

    if declare -f "$scheme" > /dev/null; then
        "$scheme"
    else
        tmux display-message "tmux-minimal-theme: unknown @minimal_theme_colorscheme '$scheme'"
    fi
}

apply_colorscheme

# Apply the theme
apply_minimal_theme
