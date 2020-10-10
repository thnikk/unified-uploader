echo off
:menu
echo This script will help you update the firmware of your keypad.
echo Please select your model:
echo  1 - 2K RGBW
echo  2 - 2K (Only use this one if the colors don't look right)
echo  3 - 4K RGBW
echo  4 - 4K (same as 2K)
echo  5 - 2K Touch
echo  6 - Macropad
choice /n /c:123456 /M "Choose an option (1-6) "
set SELECTION=%errorlevel%

wmic path Win32_SerialPort | find /I "Serial Device" | tools\awk "{print $13}" > tools\port
set /p PORT=< tools\port
mode %PORT%:1200,n,8,1 > nul
echo Resetting the board...
timeout 3 > nul
wmic path Win32_SerialPort | find /I "Serial Device" | tools\awk "{print $13}" > tools\port
set /p PORT=< tools\port

IF "%SELECTION%"=="1" (
set MODEL=2kW
) ELSE IF "%SELECTION%"=="2" (
set MODEL=2k
) ELSE IF "%SELECTION%"=="3" (
set MODEL=4kW
) ELSE IF "%SELECTION%"=="4" (
set MODEL=4k
) ELSE IF "%SELECTION%"=="5" (
set MODEL=2kTouch
) ELSE IF "%SELECTION%"=="6" (
set MODEL=Macro
)

echo Uploading code for %MODEL% Keypad...
tools\bossac.exe -i --port=%PORT% -U true -i -e -w -v firmware/%MODEL%.bin -R > nul
echo Done! Press any key to close.
pause > nul
