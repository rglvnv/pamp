@echo off
setlocal

echo Flush Dns & echo. & echo.

ipconfig /flushdns

echo Done & echo.

IF NOT "%1"=="next" (
    Timeout 6
)