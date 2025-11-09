@echo off
title Fortnite Fixer - Ajotak V2
color 0a
mode con cols=80 lines=20

:input
cls
echo ===============================================
echo         FORTNITE INSTALLATION FIXER
echo ===============================================
echo.
set /p fnpath=Enter full path to your Fortnite folder (e.g. D:\Games\Fortnite): 
if not exist "%fnpath%\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe" (
    echo.
    echo Invalid path. Fortnite not found.
    timeout /t 2 >nul
    goto input
)

echo.
echo Path found: %fnpath%
echo.
echo Renaming "Fortnite" folder to "Fortnite2"...
timeout /t 1 >nul

set "parentPath=%fnpath:~0,-8%"
cd /d "%parentPath%"
ren "Fortnite" "Fortnite2"

echo.
echo Loading...
timeout /t 1 >nul
echo Trying to refresh folder
timeout /t 1 >nul
echo Done
cls
echo Changing some values
timeout /t 1 >nul
echo Done
cls
echo Convincing Epic Games that its real
timeout /t 1 >nul
echo Done
cls

echo.
echo Now follow these steps:
echo 1. Open Epic Games Launcher
echo 2. Click INSTALL on Fortnite
echo 3. Choose the same folder: %parentPath%\Fortnite
echo 4. Let it install for about 10 seconds
echo 5. Then stop the install
echo.
pause

echo.
echo Closing Epic Games Launcher...
taskkill /f /im EpicGamesLauncher.exe >nul 2>&1
timeout /t 1 >nul

echo Deleting new empty "Fortnite" folder...
rmdir /s /q "%parentPath%\Fortnite"
timeout /t 1 >nul

echo Renaming "Fortnite2" back to "Fortnite"...
ren "%parentPath%\Fortnite2" "Fortnite"
timeout /t 1 >nul

echo Launching Epic Games Launcher...
start "" "com.epicgames.launcher://"
timeout /t 2 >nul

echo.
echo Done. Fortnite should now be detected properly.
pause
exit

