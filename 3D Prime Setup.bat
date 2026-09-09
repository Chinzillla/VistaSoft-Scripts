@echo off
REM 3D Prime Setup Script by Brandon Chin
REM Check if script was run in admin

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Run this script as admin.
    pause
    exit /b 1
)

REM Setting up core applications to run as admin for all users

set "LAYERS=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

reg.exe add "%LAYERS%" /v "C:\Program Files\Duerr\VistaSoft\BinariesCore\VistaSoft\VistaSoft.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\Program Files\Duerr\VistaSoft\Binaries\VistaSoft\VistaSoft.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\CBCT\WidePano\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\CBCT\WidePano\VAKPAR_CTG.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\CBCT\WidePano\VAKPAR_FTG.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\Ceph\WideCeph\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\Ceph\WideCeph\VAPAN_FTG.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\Pano\WidePano\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\Pano\WidePano\VAPAN_CTG.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaSoft\WorkstationService\VistaVoxPlugin\Acquisition\Pano\WidePano\VAPAN_FTG.exe" /t REG_SZ /d "~ RUNASADMIN" /f

REM Adding permissions for everyone on folders

icacls "C:\Program Files (x86)\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\ProgramData\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\Program Files\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\VistaSoftData" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C

REM Disabling: Memory Integrity, Kernel Shadow Stack, Vulnerable Driver Block List

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0 /f

REM Disable User Access Control

reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

REM Setup Task Scheduled Shutdown time

set "SHUTDOWN_TIME=23:00"
schtasks.exe /create /tn "3D Prime VistaSoft Daily Shutdown" /tr "%SystemRoot%\System32\shutdown.exe /s /f /t 60" /sc DAILY /st "%SHUTDOWN_TIME%" /ru SYSTEM /rl HIGHEST /f

REM Setup the ultimate performance power plan

setlocal EnableDelayedExpansion
set "ULTIMATE_GUID="

for /f "tokens=4" %%G in ('powercfg.exe /list ^| findstr.exe /I /C:"Ultimate Performance"') do (
    set "ULTIMATE_GUID=%%G"
)

if not defined ULTIMATE_GUID (
    for /f "tokens=4" %%G in ('powercfg.exe /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61') do (
        set "ULTIMATE_GUID=%%G"
    )
)

powercfg.exe /setactive !ULTIMATE_GUID!
powercfg.exe /getactivescheme 
echo .

REM Disable USB selective suspend on AC and battery power

powercfg.exe /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg.exe /setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg.exe /setactive SCHEME_CURRENT

REM Clear "Allow the computer to turn off this device" on USB hubs

powershell.exe -NoProfile -Command "$settings=Get-CimInstance -Namespace root/wmi -ClassName MSPower_DeviceEnable; Get-CimInstance -ClassName Win32_USBHub | ForEach-Object {$id=$_.PNPDeviceID; $settings | Where-Object {$_.InstanceName -like ('*'+$id+'*')} | Set-CimInstance -Property @{Enable=$false} | Out-Null}"

REM Disable Fast Startup

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

pause