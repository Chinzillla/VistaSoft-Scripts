@echo off

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

pause