@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: You must run this script as an Administrator!
    echo Right-click this file and select "Run as administrator".
    pause
    exit /b
)

:: Define the dynamic desktop path for any logged-in user
set "TargetFolder=%userprofile%\Desktop\CamXElaraDrivers-05212026"

:: Check if the folder exists on the desktop
if not exist "%TargetFolder%" (
    echo ERROR: Could not find the "CamXElaraDrivers-05212026" folder on your Desktop.
    echo Please make sure the folder is named exactly "CamXElaraDrivers-05212026".
    pause
    exit /b
)

echo Found DriversBackup folder. Starting driver installation...
echo -----------------------------------------------------------

:: Run the PnPUtil install command across all subdirectories
pnputil /add-driver "%TargetFolder%\*.inf" /subdirs /install

echo -----------------------------------------------------------
echo Process finished! Please restart your computer if required.
pause
