#!/usr/bin/env bash

# Catppuccin Mocha (default)
catppuccin_mocha() {
    tmux set-option -goq @minimal_theme_bg_color "#1a1d23"
    tmux set-option -goq @minimal_theme_active_color "#b4befe"
    tmux set-option -goq @minimal_theme_inactive_color "#6c7086"
    tmux set-option -goq @minimal_theme_text_color "#cdd6f4"
    tmux set-option -goq @minimal_theme_accent_color "#b4befe"
    tmux set-option -goq @minimal_theme_border_color "#44475a"
    tmux set-option -goq @minimal_theme_selection_color "#fab387"
}

# Catppuccin Frappe
catppuccin_frappe() {
    tmux set-option -goq @minimal_theme_bg_color "#303446"
    tmux set-option -goq @minimal_theme_active_color "#8caaee"
    tmux set-option -goq @minimal_theme_inactive_color "#737994"
    tmux set-option -goq @minimal_theme_text_color "#c6d0f5"
    tmux set-option -goq @minimal_theme_accent_color "#8caaee"
    tmux set-option -goq @minimal_theme_border_color "#51576d"
    tmux set-option -goq @minimal_theme_selection_color "#ef9f76"
}

# Nordfox
nordfox() {
    tmux set-option -goq @minimal_theme_bg_color "#232831"
    tmux set-option -goq @minimal_theme_active_color "#81a1c1"
    tmux set-option -goq @minimal_theme_inactive_color "#7e8188"
    tmux set-option -goq @minimal_theme_text_color "#cdcecf"
    tmux set-option -goq @minimal_theme_accent_color "#81a1c1"
    tmux set-option -goq @minimal_theme_border_color "#5a657d"
    tmux set-option -goq @minimal_theme_selection_color "#ebcb8b"
}

# Tokyo Night
tokyonight() {
    tmux set-option -goq @minimal_theme_bg_color "#1a1b26"
    tmux set-option -goq @minimal_theme_active_color "#7aa2f7"
    tmux set-option -goq @minimal_theme_inactive_color "#565f89"
    tmux set-option -goq @minimal_theme_text_color "#c0caf5"
    tmux set-option -goq @minimal_theme_accent_color "#7aa2f7"
    tmux set-option -goq @minimal_theme_border_color "#414868"
    tmux set-option -goq @minimal_theme_selection_color "#ff9364"
}

# Dracula
dracula() {
    tmux set-option -goq @minimal_theme_bg_color "#282a36"
    tmux set-option -goq @minimal_theme_active_color "#bd93f9"
    tmux set-option -goq @minimal_theme_inactive_color "#6272a4"
    tmux set-option -goq @minimal_theme_text_color "#f8f8f2"
    tmux set-option -goq @minimal_theme_accent_color "#bd93f9"
    tmux set-option -goq @minimal_theme_border_color "#44475a"
    tmux set-option -goq @minimal_theme_selection_color "#ffb86c"
}

# Gruvbox Dark
gruvbox_dark() {
    tmux set-option -goq @minimal_theme_bg_color "#1d2021"
    tmux set-option -goq @minimal_theme_active_color "#83a598"
    tmux set-option -goq @minimal_theme_inactive_color "#665c54"
    tmux set-option -goq @minimal_theme_text_color "#ebdbb2"
    tmux set-option -goq @minimal_theme_accent_color "#83a598"
    tmux set-option -goq @minimal_theme_border_color "#504945"
    tmux set-option -goq @minimal_theme_selection_color "#b8bb26"
}

# Unsets all @minimal_theme_*_color options so the next apply_colorscheme
# call (which only fills in unset colors) can apply a freshly selected
# scheme's values instead of sticking to a previous scheme/override.
clear_theme_colors() {
    tmux set-option -ug @minimal_theme_bg_color
    tmux set-option -ug @minimal_theme_active_color
    tmux set-option -ug @minimal_theme_inactive_color
    tmux set-option -ug @minimal_theme_text_color
    tmux set-option -ug @minimal_theme_accent_color
    tmux set-option -ug @minimal_theme_border_color
    tmux set-option -ug @minimal_theme_selection_color
}
