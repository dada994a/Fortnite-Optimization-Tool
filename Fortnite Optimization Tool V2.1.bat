@echo off

title Fortnite Optimization Tool V2.1

echo ================================================
echo This batch file will make registry changes.
echo It is strongly recommended to backup the registry beforehand.
echo Main registry changes: echo - Disable Game DVR
echo - Disable Game DVR
echo - Disabling Unnecessary Services
echo - Mouse setting
echo - Enable Game Mode
echo ================================================
echo.
choice /c yn /m "Do you wish to continue with this operation? [Y/N]"

if errorlevel 2 (
    echo Operation canceled.
    pause
    exit /b
)

 echo Deleting files in Temp.
 del /q /f "%temp%\*" 2>nul
 for /d %%d in ("%temp%\*") do (
 rd /s /q "%%d" 2>nul
    )


 echo Flushing DNS and resetting network settings.
 ipconfig /flushdns
 ipconfig /registerdns
 ipconfig /release
 ipconfig /renew
 netsh winsock reset


echo Applying registry settings...

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d 4 /f

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f

echo Registry settings applied successfully.

pause
