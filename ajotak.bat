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
set "logdir=%target%\logs"
if not exist "%target%" mkdir "%target%" >nul
if not exist "%logdir%" mkdir "%logdir%" >nul
set "ts=%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%"
set "ts=%ts: =0%"
set "logfile=%logdir%\log_%ts%.txt"

call :check_curl

:menu
cls
call :draw_header "AJOTAK V2"
echo.
call :draw_menu
echo.
set "choice="
set /p "choice=Select an option (1-6) > "
if "%choice%"=="1" goto woof
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto hwid
if "%choice%"=="4" goto changes
if "%choice%"=="5" goto fixer
if "%choice%"=="6" goto cup
echo Invalid selection. Press any key to continue...
pause >nul
goto menu

:draw_header
setlocal
set "title=%~1"
echo ================================================================================
echo                            %title%
echo ================================================================================
endlocal & goto :eof

:draw_menu
echo ======================================================
echo ^|  1.) Woof                               ^|  4.) Changelogs
echo ^|  2.) Clean                              ^|  5.) Fortnite Fixer
echo ^|  3.) Check Serials                      ^|  6.) Temporary Cup Spoofer (RISKY)
echo ======================================================

:check_curl
where curl >nul 2>&1
if errorlevel 1 (
    echo curl not found in PATH. Please install curl and re-run this script.
    pause
    exit /b
)
goto :eof

:log
setlocal EnableDelayedExpansion
set "timeStamp=[%date% %time%]"
echo !timeStamp! %~1>>"%logfile%"
endlocal & goto :eof

:woof
cls
call :big_status "WOOF MODE"
call :simulate_progress "Preparing files" 20
call :log "Started Woof"

curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
call :log "Downloaded amidewinx64.exe"
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
call :log "Downloaded amifldrv64.sys"
curl -L -s -o "%target%\run.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/run.bat
call :log "Downloaded run.bat"

start /min "" "%target%\run.bat"
call :log "Executed run.bat"
start "" "%target%\amidewinx64.exe" /all
call :log "Executed amidewinx64.exe /all"
echo You might need to restart your computer to apply the changes.
pause
goto menu

:clean
cls
call :big_status "CLEAN MODE"
call :simulate_progress "Refreshing toolset" 25
call :log "Started Clean"

echo Downloading cleanup tools...
for %%F in (1.exe 2.exe 3.exe 4.bat 5.exe 6.bat 7.bat 8.bat 9.bat 10.bat) do (
    curl -L -s -o "%target%\%%F" "https://raw.githubusercontent.com/beeczxd/ajotakv2/main/%%F"
    call :log "Downloaded %%F"
)
call :simulate_progress "Launching cleanup scripts" 25

for %%F in (1.exe 2.exe 3.exe 4.bat 5.exe 6.bat 7.bat 8.bat 9.bat 10.bat) do (
    start "" "%target%\%%F"
    call :log "Launched %%F"
)
echo Done.
pause
goto menu

:hwid
mode con cols=120 lines=36
cls
call :big_status "SYSTEM SERIALS"
call :log "Opened HWID menu"
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
call :log "Viewed changelogs"
echo Ajotak V2.6
echo -------------------------------------
echo - Added activity logging.
echo - Improved UI visuals and stability
echo - Made sure that Fortnite Fixer works
echo - for everything (no longer beta)
echo - Minor cleanup & smoother progress bar
echo -------------------------------------
pause
goto menu

:fixer
cls
call :big_status "FORTNITE FIXER"
call :log "Selected Fortnite Fixer"
choice /C YN /M "Proceed with Fortnite Fixer? (Y/N)"
if errorlevel 2 goto menu
if errorlevel 1 (
    call :simulate_progress "Preparing Fortnite Fixer" 25
    curl -L -s -o "%target%\fixer.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/fix.bat
    if exist "%target%\fixer.bat" (
        call :log "Downloaded fixer.bat"
        start "" "%target%\fixer.bat"
        call :log "Launched Fortnite Fixer"
        echo Fixer launched. Follow on-screen instructions.
    ) else (
        call :log "Failed to download fixer.bat"
        echo Download failed. Check your connection.
    )
    pause
)
goto menu

:cup
cls
call :big_status "CUP SPOOFER (RISKY)"
call :log "Selected Cup Spoofer"
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
        call :log "Launched cup.bat"
        echo Cup spoofer started.
    ) else (
        call :log "Cup spoofer download failed"
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
set "label=%~1"
cls
echo ================================================================================ 
echo                          %label%
echo ================================================================================ 
echo.
goto :eof

:end
exit /b

