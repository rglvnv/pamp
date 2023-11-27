@echo off
setlocal

set filename=%~n0

IF NOT "%1"=="donow" (
    PowerShell -windowstyle hidden -Command "Start-Process '%filename%.bat' -ArgumentList 'donow' -Verb RunAs"
    exit /b
)

start "" notepad.exe "%windir%\System32\drivers\etc\hosts"