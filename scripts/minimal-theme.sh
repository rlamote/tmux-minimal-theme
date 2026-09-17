#!/usr/bin/env bash

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

option_enabled() {
    case "$1" in
        on) return 0 ;;
        off) return 1 ;;
        *) return 0 ;;
    esac
}

apply_minimal_theme() {
    # Get theme colors (allow customization)
    local bg_color=$(get_tmux_option "@minimal_theme_bg_color" "#1a1d23")
    local active_color=$(get_tmux_option "@minimal_theme_active_color" "#b4befe")
    local inactive_color=$(get_tmux_option "@minimal_theme_inactive_color" "#6c7086")
    local text_color=$(get_tmux_option "@minimal_theme_text_color" "#cdd6f4")
    local accent_color=$(get_tmux_option "@minimal_theme_accent_color" "#b4befe")
    local border_color=$(get_tmux_option "@minimal_theme_border_color" "#44475a")
    local selection_color=$(get_tmux_option "@minimal_theme_selection_color" "#fab387")
    # Get status bar fields configuration
    local session_icon=$(get_tmux_option "@minimal_theme_session_icon" "")
    local machine_status=$(get_tmux_option "@minimal_theme_machine_status" "off")
    local machine_icon=$(get_tmux_option "@minimal_theme_machine_icon" "" )
    local directory_status=$(get_tmux_option "@minimal_theme_directory_status" "on")
    local dir_icon=$(get_tmux_option "@minimal_theme_dir_icon" "")
    local memory_status=$(get_tmux_option "@minimal_theme_memory_status" "on")
    local memory_icon=$(get_tmux_option "@minimal_theme_memory_icon" "")
    local date_status=$(get_tmux_option "@minimal_theme_date_status" "on")
    local date_icon=$(get_tmux_option "@minimal_theme_date_icon" "")
    local clock_status=$(get_tmux_option "@minimal_theme_clock_status" "on")
    local clock_icon=$(get_tmux_option "@minimal_theme_clock_icon" "")
    local battery_status=$(get_tmux_option "@minimal_theme_battery_status" "on")
    local battery_icon=$(get_tmux_option "@minimal_theme_battery_icon" "")

    # Status bar setup
    tmux set-option -g status on
    tmux set-option -g status-position bottom
    tmux set-option -g status-interval 3
    tmux set-option -g status-justify left

    # Status bar colors and style
    tmux set-option -g status-style "bg=$bg_color,fg=$text_color"
    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100

    # Pane borders
    tmux set-option -g pane-border-style "fg=$border_color"
    tmux set-option -g pane-active-border-style "fg=$active_color"

    # Message style
    tmux set-option -g message-style "bg=$bg_color,fg=$text_color,bold"
    tmux set-option -g message-command-style "bg=$bg_color,fg=$text_color,bold"

    # Window status format
    tmux set-option -g window-status-format "#[fg=$inactive_color,bg=$bg_color] #I:#W "
    tmux set-option -g window-status-current-format "#[fg=$active_color,bg=$bg_color,bold] #I:#W "
    tmux set-option -g window-status-separator ""

    # Status left (session name)
    local status_left="\
#{?pane_in_mode,#[fg=$bg_color]#[bg=$selection_color],#{?client_prefix,#[fg=$bg_color]#[bg=$accent_color],#[fg=$accent_color]#[bg=$bg_color]}}#[bold]$session_icon  #S \
#[fg=$inactive_color,bg=$bg_color,nobold]│ "

    tmux set-option -g status-left "$status_left"

    # Status right with configurable system info
    local -a status_right_segments=()
    option_enabled "$machine_status" &&
        status_right_segments+=("#[fg=$accent_color]$machine_icon #[fg=$text_color]#H")
    option_enabled "$directory_status" &&
        status_right_segments+=("#[fg=$accent_color]$dir_icon #[fg=$text_color]#([ #{pane_current_path} = \$HOME ] && echo '~' || basename #{pane_current_path})")
    option_enabled "$memory_status" &&
        status_right_segments+=("#[fg=$accent_color]$memory_icon #[fg=$text_color]#(free | awk '/^Mem/ { printf(\"%.0f%%\", \$3/\$2 * 100 - 0.5) }' )")
    option_enabled "$date_status" &&
        status_right_segments+=("#[fg=$accent_color]$date_icon #[fg=$text_color]#(date +%d)")
    option_enabled "$clock_status" &&
        status_right_segments+=("#[fg=$accent_color]$clock_icon #[fg=$text_color]#(date +%H:%M)")
    option_enabled "$battery_status" &&
        status_right_segments+=("#[fg=$accent_color]$battery_icon #[fg=$text_color]#(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')%")

    local status_right=""
    local segment
    for segment in "${status_right_segments[@]}"; do
        if [ -n "$status_right" ]; then
            status_right+=" #[fg=$inactive_color]│ "
        fi
        status_right+="$segment"
    done
    [ -n "$status_right" ] && status_right+=" "

    tmux set-option -g status-right "$status_right"

    # Copy mode styling
    tmux set-option -g mode-style "bg=$selection_color,fg=$bg_color"

    # Clock mode
    tmux set-option -g clock-mode-colour "$active_color"
    tmux set-option -g clock-mode-style 24
}
