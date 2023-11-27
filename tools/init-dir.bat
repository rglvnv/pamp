@echo off
setlocal

SET dir=%~dp0
FOR %%a IN ("%dir:~0,-1%") DO SET serverdir=%%~dpa
FOR %%a IN ("%serverdir:~0,-1%") DO SET containerdir=%%~dpa

set projectdir=%containerdir%project
set serverdir=%serverdir:~0,-1%

set filename=%~n0

IF NOT "%1"=="donow" (
    PowerShell -windowstyle hidden -Command "Start-Process '%filename%.bat' -ArgumentList 'donow' -Verb RunAs"
    exit /b
)

echo Check directories & echo. & echo.

if not exist "%containerdir%\db-data" (mkdir "%containerdir%\db-data")

if not exist "%serverdir%\dynamic" (mkdir "%serverdir%\dynamic")

if not exist "%serverdir%\dynamic\httpd-need" (mkdir "%serverdir%\dynamic\httpd-need")
if not exist "%serverdir%\dynamic\temp\log" (mkdir "%serverdir%\dynamic\temp\log")
if not exist "%serverdir%\dynamic\temp\profiler" (mkdir "%serverdir%\dynamic\temp\profiler")
if not exist "%serverdir%\dynamic\temp\session" (mkdir "%serverdir%\dynamic\temp\session")
if not exist "%serverdir%\dynamic\temp\sys" (mkdir "%serverdir%\dynamic\temp\sys")
if not exist "%serverdir%\dynamic\temp\upload" (mkdir "%serverdir%\dynamic\temp\upload")
if not exist "%serverdir%\dynamic\fresh" (mkdir "%serverdir%\dynamic\fresh")

if exist "%serverdir%\dynamic\.gitignore" (del "%serverdir%\dynamic\.gitignore")
echo * > "%serverdir%\dynamic\.gitignore"

if not exist "%projectdir%\test" (mkdir "%projectdir%\test")
if not exist "%projectdir%\test\index.php" (
    echo ^<^?php echo $_SERVER['SERVER_NAME']; phpinfo^(^); > "%projectdir%\test\index.php"
)

echo.
echo Done & echo.

IF NOT "%2"=="next" (
    Timeout 6
)