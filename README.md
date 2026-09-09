# Script Library for VistaSoft

VistaSoft is my Air Techniques proprietary software. Working at Air Techniques has taught me the opportunities of automating alot of the redudant work in terms of permissions, firewall rules, and registry adjustments

This library is a culmination of the Scripts that I have built for my self as a tool to reduce the time spent on calls and standardize my installations.

## Library

### 3D Prime Setup.bat

Purpose: Created to automate post-installation setup for VistaSoft 3D Prime workstations.

Redudant work automated:
- Permissions for run as administrator on core VistaSoft and 3D Prime acquisition applications
- Changing permissions for core Duerr and VistaSoft data folders for Everyone and Full Control
- Disabling Memory Integrity, Kernel Shadow Stack, and the Vulnerable Driver Block List
- Change of User Access Control disabling EnableLUA
- Creating a daily scheduled shutdown task for the workstation
- Enabling the Ultimate Performance power plan and disabling USB selective suspend
- Disabling USB hub power saving and Fast Startup
- Installing available Windows Updates and restarting only when a reboot is required

### VistaPano 2.0 Setup.bat

Purpose: Created to automate the entire setup process for a VistaPano 2.0 Post Software Installation.

Redudant work automated:
- Permissions for run as administrator on all critical applications used for Panoramic X-Rays
- Change of User Access Control Disabling EnableLUA
- Changing Permissions for core folders for Everyone and Full Control
- Creating inbound and outbound TCP Port rules in order to communicate with the VistaPano 2.0

### Provecta S-Pan Setup.bat

Purpose: Similar to the VistaPano 2.0 but curated for the Provecta S-Pan instead

Redudant work automated:
- Same as VistaPano 2.0 but different file paths for pano applications

### Server Setup.bat

Purpose: Setting up ports and permissions for VistaSoft Server workstations

Redudant work automated:
- Same as VistaPano 2.0 but no Pano Applications added to rule