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

# Detects whether @minimal_theme_colorscheme changed since the plugin was
# last (re)loaded (e.g. after `tmux source-file`). If it did, sticky colors
# left over from the previous scheme/override are cleared so the newly
# selected scheme applies cleanly instead of being blocked by "set if unset"
# semantics in apply_colorscheme.
detect_colorscheme_change() {
    local current previous
    current="$(tmux show-option -gqv "@minimal_theme_colorscheme")"
    previous="$(tmux show-option -gqv "@minimal_theme_last_colorscheme")"

    if [ "$current" != "$previous" ]; then
        clear_theme_colors
        tmux set-option -gq "@minimal_theme_last_colorscheme" "$current"
    fi
}

detect_colorscheme_change
apply_colorscheme

# Apply the theme
apply_minimal_theme
