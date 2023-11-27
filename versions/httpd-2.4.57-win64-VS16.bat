@echo off
setlocal

SET dir=%~dp0
FOR %%a IN ("%dir:~0,-1%") DO SET serverdir=%%~dpa
FOR %%a IN ("%serverdir:~0,-1%") DO SET containerdir=%%~dpa

set projectdir=%containerdir%project
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

echo Change Httpd version & echo. & echo.

cmd /c cscript //Nologo "%serverdir%\stop.vbs" next

if exist "%serverdir%\dynamic\httpd" (rmdir "%serverdir%\dynamic\httpd")
mklink /D "%serverdir%\dynamic\httpd" "%serverdir%\dynamic\fresh\%filename%"

cmd /c cscript //Nologo "%serverdir%\others\edit-httpd-conf.vbs" "%serverdir%\dynamic\httpd\conf\httpd.conf"

if exist "%serverdir%\dynamic\httpd\logs" (rmdir "%serverdir%\dynamic\httpd\logs")
if exist "%serverdir%\dynamic\httpd\logs" (move "%serverdir%\dynamic\httpd\logs" "%serverdir%\dynamic\httpd\logs%RANDOM%%RANDOM%")
mklink /D "%serverdir%\dynamic\httpd\logs" "%serverdir%\dynamic\temp\log"

if exist "%serverdir%\dynamic\httpd\conf\httpd-vhosts" (rmdir "%serverdir%\dynamic\httpd\conf\httpd-vhosts")
mklink /D "%serverdir%\dynamic\httpd\conf\httpd-vhosts" "%serverdir%\httpd-vhosts"

if exist "%serverdir%\dynamic\httpd\conf\httpd-need" (rmdir "%serverdir%\dynamic\httpd\conf\httpd-need")
mklink /D "%serverdir%\dynamic\httpd\conf\httpd-need" "%serverdir%\dynamic\httpd-need"

if exist "%serverdir%\dynamic\httpd-need\httpd-variables.conf" (del "%serverdir%\dynamic\httpd-need\httpd-variables.conf")
echo Define serverdir "%serverdir%" > "%serverdir%\dynamic\httpd-need\httpd-variables.conf"
echo Define projectdir "%projectdir%" >> "%serverdir%\dynamic\httpd-need\httpd-variables.conf"

echo.
echo Done & echo.

Timeout 6