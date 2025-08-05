@echo off
chcp 65001 >nul 2>&1
cd /d "E:\wsl\win-notify"

echo Starting BurntToast notification test...
echo.

powershell.exe -ExecutionPolicy Bypass -Command "chcp 65001 | Out-Null; Set-Location 'E:\wsl\win-notify'; .\toast-notify.ps1 -Title 'Test Success' -Message 'BurntToast system is working!' -Icon 'icons\success.png' -CustomSound 'Default' -Type 'success'"

echo.
echo Test completed!
echo Press any key to exit...
pause >nul