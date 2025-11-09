@echo off
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

title Ajotak V2
color 0c
mode con cols=70 lines=25
setlocal EnableDelayedExpansion
set "target=C:\Users\%username%\ajotak"
if not exist "%target%" mkdir "%target%"

:menu
cls
echo.
echo.
echo ======================================================
echo                    AJOTAK V2
echo ======================================================
echo   1.) Woof
echo   2.) Clean
echo   3.) Check Serials
echo   4.) Changelogs
echo ======================================================
echo.
set /p choice= Selection: 

if "%choice%"=="1" goto woof
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto hwid
if "%choice%"=="4" goto changes
goto menu

:woof
cls
call :progress "Woofing"
curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
curl -L -s -o "%target%\run.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/run.bat
start /min "" "%target%\run.bat"
echo Your computer WILL restart when the process is done.
goto menu

:clean
cls
call :progress "Cleaning"

curl -L -s -o "%target%\1.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/1.exe
curl -L -s -o "%target%\2.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/2.exe
curl -L -s -o "%target%\3.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/3.exe
curl -L -s -o "%target%\4.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/4.bat
curl -L -s -o "%target%\5.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/5.exe
curl -L -s -o "%target%\6.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/6.bat
curl -L -s -o "%target%\7.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/7.bat
curl -L -s -o "%target%\8.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/8.bat
curl -L -s -o "%target%\9.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/9.bat
curl -L -s -o "%target%\10.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/10.bat

start "" "%target%\1.exe"
start "" "%target%\2.exe"
start "" "%target%\3.exe"
start "" "%target%\4.bat"
start "" "%target%\5.exe"
start "" "%target%\6.bat"
start "" "%target%\7.bat"
start "" "%target%\8.bat"
start "" "%target%\9.bat"
start "" "%target%\10.bat"

goto menu

:hwid
mode con: cols=160 lines=60
cls
echo Machine GUID:
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid
echo.

echo Drive Serial Numbers:
wmic diskdrive get SerialNumber
echo.

echo Baseboard Info:
wmic baseboard get product, manufacturer, serialnumber
wmic bios get serialnumber
echo.

echo UUID:
wmic csproduct get UUID
echo.

echo CPU:
powershell -Command "Get-WmiObject Win32_Processor | ForEach-Object { $_.SerialNumber }"
echo.

echo GPU:
wmic path win32_VideoController get name
echo.

pause
mode con: cols=70 lines=25
goto menu

:progress
set "task=%~1"
for /L %%i in (1,10,100) do (
    timeout /nobreak /t 1 >nul
    cls
    echo %task%... %%i%%
)
exit /b

:changes
echo Ajotak V2.3
echo -------------------------------------
echo Made spoofing even faster than before.
echo Tester lasted for 3+ hours on a locked motherboard.
echo Added a feature where if you have Fortnite installed
echo you can get it back on Epic Games after you clean.
echo ------------------------------------- 
pause
goto menu
:end
exit /b




