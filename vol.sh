#!/bin/sh

# Fallback value
VOL_STEPS=5

# Prints out the current volume
vol() {
    echo "Volume: $(pamixer --get-volume)%"
}

# Increases the volume by fallback value or parameter
inc() {
    [[ -n "$1" ]] && VOL_STEPS=$1 # If no value is given, use fallback value
    pamixer --unmute --increase $VOL_STEPS
    [[ -z "$2" ]] && noti && vol
}

# Decreases the volume by fallback value or parameter
dec() {
    [[ -n "$1" ]] && VOL_STEPS=$1 # If no value is given, use fallback value
    pamixer --unmute --decrease $VOL_STEPS
    [[ -z "$2" ]] && noti && vol
}

# Mute the channel
mute() {
    pamixer --toggle
    noti
}

# Callback to splashscreen of volnoti.
# This could be removed to reduce dependencies.
noti() {
    local v=$(pamixer --get-volume)
    local m=$(pamixer --get-mute)
    [[ "$v" -gt 100 ]] && v=100 # max value
    [[ "$m" == "true" ]] && { volnoti-show -m; return; }
    [[ "$v" -eq 0 ]] && volnoti-show -m || volnoti-show $v
}

# Prints out the helpmenu
showhelp() {
    echo "./$0 <arg> <val>"
    echo "<arg> i/inc/increase:  increase volume by <val>"
    echo "      d/dec/decrease:  decrease volume by <val>"
    echo "      m/mute:          mute/demute. no <val>"
    echo "      n/noti/notify:   show a notification splash. no <val>"
    echo "Default output is the current volume."
}

# Show help if no parameter is given
[[ ! -n "$1" ]] && showhelp

# Now do everything the user wants
case "$1" in
    i|inc|increase)
        inc "$2" "$3"
        ;;
    d|dec|decrease)
        dec "$2" "$3"
        ;;
    m|mute)
        mute
        ;;
    n|noti|notify)
        noti
        ;;
    *)
        vol
        ;;
esac
