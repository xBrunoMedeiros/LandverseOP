@echo off

:: Enable delayed expansion for real-time variable updates inside loops
setlocal enabledelayedexpansion

:: Save current cwd
set "CURRENT_CWD=%cd%"

REM This script starts the CLIENT with a specified account configuration.
if "%~1"=="" (
    set /p account="Enter the account index or name (e.g., 0, account1): "
) else (
    set account=%~1
)

REM If account is empty, throw error and exit
if "%account%"=="" (
    echo No account specified. Exiting...
    exit /b
)

REM If account is a number, format account file
if "%account:~0,1%" geq "0" if "%account:~0,1%" leq "9" (
    set account_file=accounts\account%account%.txt
) else (
    set account_file=accounts\%account%.txt
)

REM If account not exist, throw error and exit
if not exist "%account_file%" (
    echo Account file "%account_file%" does not exist.
    exit /b
)

:: Load 'config.ini'
for /f "tokens=1,2 delims==" %%a in (config.ini) do (
    if %%a==GAME_FOLDER set GAME_FOLDER=%%b
    if %%a==GAME_EXE set GAME_EXE=%%b
    if %%a==GAME_ARG set GAME_ARG=%%b
)

:: Load 'account.txt'
for /f "usebackq tokens=1,* delims= " %%a in ("%account_file%") do (
    if /i "%%a"=="username"         set "RO_USERNAME=%%b"
    if /i "%%a"=="password"         set "RO_PASSWORD=%%b"
    if /i "%%a"=="char"             set "RO_CHAR=%%b"
    if /i "%%a"=="XKore_listenIp"   set "OPENKORE_HOST=%%b"
    if /i "%%a"=="XKore_port"       set "OPENKORE_PORT=%%b"
)

:: Set game server
set RO_SERVER=0

:: Set game cwd
cd /d %GAME_FOLDER%

:: Run game exe
for /f %%p in ('powershell -nologo -command "Start-Process -FilePath '%GAME_EXE%' -ArgumentList '%GAME_ARG%' -PassThru | Select-Object -ExpandProperty Id"') do (
    set "GAME_PID=%%p"
)

:: Set openkore cwd
cd /d %CURRENT_CWD%

:: Run openkore perl
perl openkore.pl --config="%account_file%"

:: Kill game process
taskkill /PID %GAME_PID% /F