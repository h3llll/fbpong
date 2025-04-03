#!/bin/bash

clear

tput civis  # Hide cursor

frames=(
    "HELP"
    "SPONGEBOB IS BREEDING ME"
    "NO SPONGEBOB STOP"
    "OH GOD PATRICK DON'T DO "
    "PATRICK YOU'RE SO BIG"
    "OH SPONGEBOB YOU'RE HUGE"
    "NO PATRICK PLEASE PLEASE"
)

while true; do
    x=$((RANDOM % $(tput cols)))
    y=$((RANDOM % $(tput lines)))

    effect=$((RANDOM % 3))  # Random ANSI effect
    case $effect in
        0) effect_code="1" ;;  # Bold
        1) effect_code="7" ;;  # Inverted colors
        2) effect_code="4" ;;  # Underline
    esac

    tput cup $y $x
    echo -ne "\e[${effect_code}m${frames[RANDOM % ${#frames[@]}]}"

    sleep 0.05
done

tput cnorm  # Restore cursor

