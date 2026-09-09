@echo off

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Run this script as admin.
    pause
    exit /b 1
)

set "LAYERS=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

reg.exe add "%LAYERS%" /v "C:\Program Files\Duerr\VistaSoft\BinariesCore\VistaSoft\VistaSoft.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\Program Files\Duerr\VistaSoft\Binaries\VistaSoft\VistaSoft.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Pano\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Pano\VAPAN_FET.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Pano\VAPAN_FET_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Fast\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Fast\VAPAN_FET.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Fast\VAPAN_FET_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Norm\VAKCAP.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Norm\VAPAN_FET.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg.exe add "%LAYERS%" /v "C:\ProgramData\Duerr\VistaPano\Acquisition\Ceph_Norm\VAPAN_FET_S.exe" /t REG_SZ /d "~ RUNASADMIN" /f

reg.exe add "%LAYERS%" /v "C:\Program Files (x86)\Duerr\VistaPano\exe\VistaPano.exe" /t REG_SZ /d "~ RUNASADMIN" /f

icacls "C:\Program Files (x86)\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\ProgramData\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\Program Files\Duerr" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C
icacls "C:\VistaSoftData" /grant:r "*S-1-1-0:(OI)(CI)F" /T /C

netsh advfirewall firewall add rule name="VistaPano 2.0" dir=in action=allow protocol=TCP localport=54466,31175 profile=domain,private enable=yes
netsh advfirewall firewall add rule name="VistaPano 2.0" dir=out action=allow protocol=TCP remoteport=54466,31175 profile=domain,private enable=yes

reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

pause