echo off
:menu
echo This script will help you update the firmware of your keypad.
echo Please select your model:
echo  1 - 2K
echo  2 - 4K
echo  3 - MegaTouch
choice /n /c:123 /M "Choose an option (1-3) "
set SELECTION=%errorlevel%

wmic path Win32_SerialPort | find /I "Serial Device" | tools\win\awk "{print $13}" > tools\port
set /p PORT=< tools\port
mode %PORT%:1200,n,8,1 > nul
echo Resetting the board...
timeout 3 > nul
wmic path Win32_SerialPort | find /I "Serial Device" | tools\win\awk "{print $13}" > tools\port
set /p PORT=< tools\port

echo Uploading code for %MODEL% keypad...
tools\win\bossac.exe -i --port=%PORT% -U true -i -e -w -v firmware/%MODEL%.bin -R > nul
echo Done! Press any key to close.
pause > nul
