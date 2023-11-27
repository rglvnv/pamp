@echo off
setlocal

SET dir=%~dp0
FOR %%a IN ("%dir:~0,-1%") DO SET serverdir=%%~dpa

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

echo Change PHP version & echo. & echo.

cmd /c cscript //Nologo "%serverdir%\stop.vbs" next

if exist "%serverdir%\dynamic\php" (rmdir "%serverdir%\dynamic\php")
mklink /D "%serverdir%\dynamic\php" "%serverdir%\dynamic\fresh\%filename%"

echo # > "%serverdir%\dynamic\php\httpd-php.conf"
if exist "%serverdir%\dynamic\php\php5apache2_4.dll" (
    echo LoadModule php5_module "%serverdir%\dynamic\php\php5apache2_4.dll" >> "%serverdir%\dynamic\php\httpd-php.conf"
)
if exist "%serverdir%\dynamic\php\php7apache2_4.dll" (
    echo LoadModule php7_module "%serverdir%\dynamic\php\php7apache2_4.dll" >> "%serverdir%\dynamic\php\httpd-php.conf"
)
if exist "%serverdir%\dynamic\php\php8apache2_4.dll" (
    echo LoadModule php_module "%serverdir%\dynamic\php\php8apache2_4.dll" >> "%serverdir%\dynamic\php\httpd-php.conf"
)
echo PHPIniDir "%serverdir%\dynamic\php" >> "%serverdir%\dynamic\php\httpd-php.conf"

cmd /c cscript //Nologo "%serverdir%\others\copy-php-ini.vbs" "%serverdir%\dynamic\php\php.ini-development" "%serverdir%\dynamic\php\php.ini"

if exist "%serverdir%\dynamic\php\temp" (rmdir "%serverdir%\dynamic\php\temp")
mklink /D "%serverdir%\dynamic\php\temp" "%serverdir%\dynamic\temp"

echo.
echo Done & echo.

Timeout 6