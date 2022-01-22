#!/usr/bin/env sh

if [ -z "$2" ]; then
    PORT=/dev/"$(ls /dev/ | grep ttyACM)"
else
    PORT="$2"
fi

if [ -z "$1" ]; then
    echo "This script will help you update the firmware of your keypad."
    echo "Please select your model:"
    echo "1 - 2k"
    echo "2 - 4k"
    echo "3 - MegaTouch"
    echo "Choose an option (1-3)"
    read -r SELECTION

    case $SELECTION in
        1) MODEL="2k" ;;
        2) MODEL="4k" ;;
        3) MODEL="MegaTouch" ;;
    esac
else
    MODEL=$1
fi

echo "Resetting the board..."
stty -F "$PORT" 1200
sleep 2
echo "Uploading code for $MODEL."
echo "File should be at firmware/$MODEL.bin"
tools/linux-x86/bossac -d -p "$PORT" -e -w -v --reset --offset 0x2000 "firmware/$MODEL.bin"
echo "Done! Press enter to exit..."
[ -z $1 ] && read -r
