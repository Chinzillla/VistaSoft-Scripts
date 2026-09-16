@echo off
REM Provecta S-Pan Setup Script by Brandon Chin
REM Check if script was run in admin

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Run this script as admin.
    pause
    exit /b 1
)

REM Setting up core applications to run as admin for all users

set "LAYERS=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

reg.exe add "%LAYERS%" /v "C:\Program Files\Air Techniques\VisionX\BinariesCore\VisionX\VisionX.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Pano\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Pano\VAPAN_ETH.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Pano\VAPAN_ETH_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Pano\VAPAN_PLX_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Fast\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Fast\VAPAN_ETH.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Fast\VAPAN_ETH_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Norm\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Norm\VAPAN_ETH.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Air Techniques\VistaPano\Acquisition\Ceph_Norm\VAPAN_ETH_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\Program Files (x86)\Air Techniques\VistaPano\exe\VistaPano.exe" /t REG_SZ /d "~ RUNASADMIN" /f

REM Adding permissions for everyone on folders

icacls "C:\Program Files (x86)\Air Techniques" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\ProgramData\Air Techniques" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\Program Files\Air Techniques" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C

REM Disabling: Memory Integrity, Kernel Shadow Stack, Vulnerable Driver Block List

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0 /f

REM Disable User Access Control

reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

pause