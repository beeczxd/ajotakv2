@echo off
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

title Ajotak V2
color 0a
mode con cols=85 lines=25
setlocal EnableDelayedExpansion

set "target=C:\Users\%USERNAME%\ajotak"
if not exist "%target%" mkdir "%target%" >nul

:menu
cls
call :draw_header "AJOTAK V2"
echo.
call :draw_menu
echo.
set /p "choice=Select an option (1-6) > "
if "%choice%"=="1" goto spoof
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto hwid
if "%choice%"=="4" goto changes
if "%choice%"=="5" goto fixer
if "%choice%"=="6" goto cup
echo Invalid selection. Press any key to continue...
pause >nul
goto menu

:draw_header
echo ================================================================================
echo                            %~1
echo ================================================================================
goto :eof

:draw_menu
echo ======================================================
echo ^|  1.) Spoof                              ^|  4.) Changelogs
echo ^|  2.) Clean                              ^|  5.) Fortnite Fixer
echo ^|  3.) Check Serials                      ^|  6.) Temporary Cup Spoofer (RISKY)
echo ======================================================
goto :eof

:spoof
cls
call :big_status "SPOOFING IN PROGRESS"
call :simulate_progress "Preparing files" 20

curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
curl -L -s -o "%target%\woofer.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/woofer.bat

timeout /t 1 >nul
start /min "" "%target%\woofer.bat"
start "" "%target%\amidewinx64.exe" /all
echo.
echo Spoofing completed. You might need to restart your PC.
pause
goto menu

:clean
cls
call :big_status "CLEANING IN PROGRESS"
call :simulate_progress "Refreshing toolset" 25

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

timeout /t 1 >nul
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

echo.
echo Cleaning completed successfully.
pause
goto menu

:hwid
mode con cols=120 lines=36
cls
call :big_status "SYSTEM SERIALS"
echo.
echo Machine GUID:
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid
echo.
echo Drive Serial Numbers:
wmic diskdrive get SerialNumber
echo.
echo Baseboard Info:
wmic baseboard get product,manufacturer,serialnumber
wmic bios get serialnumber
echo.
echo UUID:
wmic csproduct get UUID
echo.
echo CPU:
powershell -Command "Get-WmiObject Win32_Processor | ForEach-Object { $_.ProcessorId }"
echo.
echo GPU:
wmic path win32_VideoController get name
echo.
pause
mode con cols=70 lines=25
goto menu

:changes
cls
call :big_status "CHANGELOGS"
echo Ajotak V2.6
echo -------------------------------------
echo - Added better spoofing workflow
echo - Simplified curl style to match legacy layout
echo - Updated Woofer support
echo - Improved progress visuals
echo -------------------------------------
pause
goto menu

:fixer
cls
call :big_status "FORTNITE FIXER"
echo This will attempt a non-destructive repair.
choice /C YN /M "Proceed with Fortnite Fixer? (Y/N)"
if errorlevel 2 goto menu
if errorlevel 1 (
    call :simulate_progress "Preparing Fortnite Fixer" 25
    curl -L -s -o "%target%\fixer.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/fix.bat
    if exist "%target%\fixer.bat" (
        start "" "%target%\fixer.bat"
        echo Fixer launched. Follow on-screen instructions.
    ) else (
        echo Download failed. Check your connection.
    )
    pause
)
goto menu

:cup
cls
call :big_status "CUP SPOOFER (RISKY)"
echo WARNING: This is experimental and risky.
choice /C YN /M "Continue anyway? (Y/N)"
if errorlevel 2 goto menu
if errorlevel 1 (
    call :simulate_progress "Preparing Cup Spoofer" 25
    curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
    curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
    curl -L -s -o "%target%\cup.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/cup.bat
    if exist "%target%\cup.bat" (
        start "" "%target%\cup.bat"
        echo Cup spoofer started.
    ) else (
        echo Download failed.
    )
    pause
)
goto menu

:simulate_progress
set "msg=%~1"
set /a total=%~2
if %total% lss 1 set total=30
set /a step = total / 20
if %step% lss 1 set step=1
for /L %%p in (1,1,20) do (
    set /a perc = (%%p * 100) / 20
    set "line=["
    for /L %%j in (1,1,%%p) do set "line=!line!=#"
    for /L %%k in (%%p,1,19) do set "line=!line! "
    set "line=!line!] !perc!%%  - %msg%"
    cls
    echo =============================================================
    echo                       Ajotak V2 - Working
    echo =============================================================
    echo.
    echo !line!
    timeout /t %step% >nul
)
goto :eof

:big_status
cls
echo ================================================================================ 
echo                          %~1
echo ================================================================================ 
echo.
goto :eof

:end
exit /b
