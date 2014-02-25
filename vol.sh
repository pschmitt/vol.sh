#!/bin/sh

VOL_STEPS=5

vol() {
    pamixer --get-volume
}

inc() {
    [[ -n "$1" ]] && VOL_STEPS=$1
    pamixer --unmute --allow-boost --increase $VOL_STEPS
    [[ -z "$2" ]] && noti
}

dec() {
    [[ -n "$1" ]] && VOL_STEPS=$1
    pamixer --unmute --allow-boost --decrease $VOL_STEPS
    [[ -z "$2" ]] && noti
}

mute() {
    pamixer --toggle
    noti
}

noti() {
    local v=$(pamixer --get-volume)
    local m=$(pamixer --get-mute)
    [[ "$v" -gt 100 ]] && v=100 # max value
    [[ "$m" == "true" ]] && { volnoti-show -m; return; }
    [[ "$v" -eq 0 ]] && volnoti-show -m || volnoti-show $v
}

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
