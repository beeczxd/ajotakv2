@echo off
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

color a
echo Connecting to the server...
timeout /nobreak /t 5 >nul
echo Loading....
timeout /nobreak /t 3 >nul
cls
echo Connection successful!
echo Please wait. Loading the main page...
timeout /nobreak /t 2 >nul
cls

title Ajotak V2
color 0a
mode con cols=85 lines=25
setlocal EnableDelayedExpansion

set "target=C:\Users\%username%\ajotak"
if not exist "%target%" mkdir "%target%" >nul

set "verfile=%temp%\ajotak_version.txt"
curl -L -s -o "%verfile%" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/version.txt >nul 2>&1
if exist "%verfile%" (
    set /p AJOVER=<"%verfile%"
) else (
    set "AJOVER=404 - There seems to be an issue with connecting to the server."
)

:menu
cls
echo ================================================================================
echo                            AJOTAK V2
echo                        VERSION - %AJOVER%
echo ================================================================================
echo.
echo   1.) Spoof                         5.) Fortnite Fixer
echo   2.) Clean                         6.) Temporary Cup Spoofer (RISKY)
echo   3.) Check Serials                 7.) Auto Spoof (On Startup)
echo   4.) Changelogs                    8.) Coming soon
echo ================================================================================
echo.
set /p choice= Select an option (1-8): 

if "%choice%"=="1" goto woof
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto hwid
if "%choice%"=="4" goto changes
if "%choice%"=="5" goto fixer
if "%choice%"=="6" goto cup
if "%choice%"=="7" goto start
if "%choice%"=="8" goto changes
goto menu

:woof
cls
curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
curl -L -s -o "%target%\run.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/run.bat
start %target%\run.bat
echo.
echo Spoof completed successfully.
echo You might need to restart your computer to apply the changes.
timeout -t 3 /nobreak
start %target%\amidewinx64.exe /all
pause
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

start %target%\1.exe
start %target%\2.exe
start %target%\3.exe
start %target%\4.bat
start %target%\5.exe
start %target%\6.bat
start %target%\7.bat
start %target%\8.bat
start %target%\9.bat
start %target%\10.bat

echo.
echo Cleaning completed successfully.
pause
goto menu

:hwid
mode con cols=120 lines=36
cls
echo ================================================================================
echo                             SYSTEM SERIALS
echo ================================================================================
echo.
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
mode con cols=70 lines=25
goto menu

:progress
set "task=%~1"
for /L %%i in (1,10,100) do (
    timeout /nobreak /t 1 >nul
    cls
    echo =============================================================
    echo                           Ajotak V%AJOVER%
    echo                    We make dreams come true.
    echo =============================================================
    echo.
    echo %task%... %%i%%
)
exit /b

:changes
cls
echo ================================================================================
echo                                CHANGELOGS
echo ================================================================================
echo Ajotak V%AJOVER%
echo -------------------------------------
echo - V2.6 is out of beta.
echo - Added auto spoof option (in testing)
echo - Fixed connection issues.
echo -------------------------------------
pause
goto menu

:fixer
cls
echo ================================================================================
echo                              FORTNITE FIXER
echo ================================================================================
curl -L -s -o "%target%\fixer.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/fix.bat
start %target%\fixer.bat
echo.
echo Fixer launched. Follow on-screen instructions.
pause
goto menu

:cup
cls
call :progress "Cup Fixer"
curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
curl -L -s -o "%target%\cup.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/cup.bat
start %target%\cup.bat
echo.
echo Cup spoofer started. Use at your own risk.
pause
goto menu

:start
curl -L -s -o "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\auto.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/auto.bat
timeout /nobreak /t 3 >nul
echo Successfully added ajotak to start up.
pause 
goto menu

:end
exit /b

























