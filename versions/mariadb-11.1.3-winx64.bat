@echo off
setlocal

SET dir=%~dp0
FOR %%a IN ("%dir:~0,-1%") DO SET serverdir=%%~dpa
FOR %%a IN ("%serverdir:~0,-1%") DO SET containerdir=%%~dpa

set serverdir=%serverdir:~0,-1%
set filename=%~n0

if not exist "%serverdir%\dynamic\fresh\%filename%" (
    echo Not found "%serverdir%\dynamic\fresh\%filename%"
    Timeout 10
    exit
)

IF NOT "%1"=="donow" (
    PowerShell -windowstyle hidden -Command "Start-Process '%filename%.bat' -ArgumentList 'donow' -Verb RunAs"
    exit /b
)

echo Change MariaDB version & echo. & echo.

cmd /c cscript //Nologo "%serverdir%\stop.vbs" next

if exist "%serverdir%\dynamic\mariadb" (rmdir "%serverdir%\dynamic\mariadb")
mklink /D "%serverdir%\dynamic\mariadb" "%serverdir%\dynamic\fresh\%filename%"

if not exist "%serverdir%\dynamic\mariadb\my.ini" (
    echo # > "%serverdir%\dynamic\mariadb\my.ini"
    echo [mysqld] >> "%serverdir%\dynamic\mariadb\my.ini"
    echo character-set-server=utf8mb4 >> "%serverdir%\dynamic\mariadb\my.ini"
    echo skip_name_resolve=on >> "%serverdir%\dynamic\mariadb\my.ini"
    echo skip_grant_tables=on >> "%serverdir%\dynamic\mariadb\my.ini"
    echo innodb_file_per_table=on >> "%serverdir%\dynamic\mariadb\my.ini"
)

if exist "%serverdir%\dynamic\mariadb\data" (rmdir "%serverdir%\dynamic\mariadb\data")
if exist "%serverdir%\dynamic\mariadb\data" (move "%serverdir%\dynamic\mariadb\data" "%serverdir%\dynamic\mariadb\data%RANDOM%%RANDOM%")
mklink /D "%serverdir%\dynamic\mariadb\data" "%containerdir%\db-data"

echo.
echo Done & echo.

Timeout 6