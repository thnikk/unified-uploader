#!/usr/bin/env sh

if [ "$(uname)" = "Darwin" ]; then
	PRE_PORT="tty.usbmodem"
	BIN_PATH="tools/mac"
else
	PRE_PORT="ttyACM"
	BIN_PATH="tools/linux-x86"
fi

if [ -z "$2" ]; then
    PORT=/dev/"$(ls /dev/ | grep $PRE_PORT)"
else
    PORT="$2"
fi

if [ -z "$1" ]; then
    echo "This script will help you update the firmware of your keypad."
    echo "Please select your model:"
    echo "1 - 2k"
    echo "2 - 2k RGBW (select this if the colors don't look right with the 2k option"
    echo "3 - 4k"
    echo "4 - 4K RGBW (same as 2k RGBW)"
    echo "5 - 2k Touch"
    echo "6 - Macropad"
    echo "Choose an option (1-6)"
    read -r SELECTION

    case $SELECTION in
        1) MODEL="2k" ;;
        2) MODEL="2kW" ;;
        3) MODEL="4k" ;;
        4) MODEL="4kW" ;;
        5) MODEL="2kTouch" ;;
        6) MODEL="Macro" ;;
    esac
else
    MODEL=$1
fi

echo "Resetting the board..."
if [ "$(uname)" = "Darwin" ]; then
	stty -f "$PORT" 1200
else
	stty -F "$PORT" 1200
fi
sleep 2
echo "Uploading code for $MODEL"
echo "File should be at firmware/$MODEL.bin"
"${BIN_PATH}/bossac" -d -p "$PORT" -e -w -v --reset --offset 0x2000 "firmware/$MODEL.bin"
echo "Done! Press enter to exit..."
[ -z $1 ] && read -r
