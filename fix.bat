@echo off
title Fortnite Fixer - Ajotak V2
color 0b
mode con cols=80 lines=20

echo ===============================================
echo         FORTNITE INSTALLATION FIXER
echo ===============================================
echo.
set /p fnpath=Enter the full path to your Fortnite folder (For example D:\Games\Fortnite): 

if not exist "%fnpath%" (
    echo.
    echo Error 404: The path you entered doesn't exist.
    pause
    exit /b
)

ren "%fnpath%" Fortnite2
echo.
echo Renamed "Fortnite" to "Fortnite2" ✅

echo.
echo NOW do the following:
echo 1. Open Epic Games Launcher
echo 2. Click INSTALL on Fortnite
echo 3. Choose the same location: %fnpath%
echo 4. Let it start for 10 seconds, then STOP the install
echo 5. Then go back to this command and click enter.
echo.
pause

echo Killing Epic Games Launcher...
taskkill /f /im EpicGamesLauncher.exe >nul 2>&1

echo Cleaning up fake Fortnite folder...
rmdir /s /q "%fnpath%"

echo Restoring real Fortnite folder...
ren "%fnpath:~0,-1%Fortnite2" Fortnite

echo Reopening Epic Games Launcher...
start "" "com.epicgames.launcher://"

echo.
echo All done. Fortnite should now say "Launch" in Epic Games.
pause
exit
