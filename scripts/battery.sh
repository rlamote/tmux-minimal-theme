#!/usr/bin/env sh
# Prints battery capacity with a trailing % only when a valid number is found.
c=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
case "$c" in
    ''|*[!0-9]*)
        echo 'N/A'
        ;;
    *)
        echo "${c}%"
        ;;
esac
