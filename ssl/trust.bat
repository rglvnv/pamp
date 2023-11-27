@echo off
setlocal

set filename=%~n0
SET action=%~1

IF "%action%"=="donow" (
    certutil -addstore root "%~dp0rootCA.pem"

    echo.
    echo Done & echo.

    Timeout 6
) ELSE (
    PowerShell -windowstyle hidden -Command "Start-Process '%filename%.bat' -ArgumentList 'donow' -Verb RunAs"
)