@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
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
echo ======================================================
echo.
set /p choice= Selection: 

if "%choice%"=="1" goto woof
if "%choice%"=="2" goto clean
if "%choice%"=="3" goto hwid
goto menu

:woof
cls
call :progress "Woofing"
curl -L -s -o "%target%\amidewinx64.exe" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/AMIDEWINx64.EXE
curl -L -s -o "%target%\amifldrv64.sys" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/amifldrv64.sys
curl -L -s -o "%target%\run.bat" https://github.com/beeczxd/ajotakv2/raw/refs/heads/main/run.bat
start /min "" "%target%\run.bat"
goto end

:clean
cls
call :progress "Cleaning"
for /L %%I in (1,1,10) do (
    curl -L -o "%target%\1.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/1.exe
    curl -L -o "%target%\2.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/2.exe
    curl -L -o "%target%\3.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/3.exe
    curl -L -o "%target%\4.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/4.bat
    curl -L -o "%target%\5.exe" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/5.exe
    curl -L -o "%target%\6.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/6.bat
    curl -L -o "%target%\7.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/7.bat
    curl -L -o "%target%\8.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/8.bat
    curl -L -o "%target%\9.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/9.bat
    curl -L -o "%target%\10.bat" https://raw.githubusercontent.com/beeczxd/ajotakv2/main/10.bat
    start /min "" "%target%\1.exe"
    start /min "" "%target%\2.exe"
    start /min "" "%target%\3.exe"
    start /min "" "%target%\4.bat"
    start /min "" "%target%\5.exe"
    start /min "" "%target%\6.bat"
    start /min "" "%target%\7.bat"
    start /min "" "%target%\8.bat"
    start /min "" "%target%\9.bat"
    start /min "" "%target%\10.bat"
)
goto end

:hwid
cls
echo Machine GUID:
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid
echo.

echo RAM (in MB):
wmic computersystem get TotalPhysicalMemory | findstr /R /C:"[0-9]"
echo.

echo Drive Serial Numbers:
wmic diskdrive get SerialNumber
echo.

echo CPU:
wmic cpu get Name
echo.

echo Baseboard Info:
wmic baseboard get product, manufacturer, serialnumber
wmic bios get serialnumber
echo.

echo UUID:
wmic csproduct get UUID
echo.

echo GPU:
wmic path win32_VideoController get name
echo.

pause
goto menu

:progress
set "task=%~1"
for /L %%i in (1,10,100) do (
    timeout /nobreak /t 1 >nul
    cls
    echo %task%... %%i%%
)
exit /b