# build-hv.ps1 – Automate VM creation and Windows 10 installation using Hyper-V

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# ====== CONFIGURATION ======
$vmName     = "AutomatedWin10"
$vhdPath    = "C:\ISO Folder\AutomatedWin10.vhdx"
$windowsISO = "C:\ISO Folder\en-us_windows_10_consumer_editions_version_22h2_x64_dvd_8da72ab3.iso"
$answerISO  = "C:\ISO Folder\answer.iso"
$vmMemory   = 4GB

# ====== CREATE VHDX DISK ======
New-VHD -Path $vhdPath -SizeBytes 40GB -Dynamic

# ====== CREATE VM ======
New-VM -Name $vmName -Generation 2 -MemoryStartupBytes $vmMemory -VHDPath $vhdPath

# ====== DISABLE SECURE BOOT ======
Set-VMFirmware -VMName $vmName -EnableSecureBoot Off

# ====== ATTACH INSTALLATION MEDIA ======
Add-VMDvdDrive -VMName $vmName -Path $windowsISO
Add-VMDvdDrive -VMName $vmName -Path $answerISO

# ====== START THE VM ======
Start-VM -Name $vmName
