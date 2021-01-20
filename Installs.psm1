##########
# Win 10 / Server 2016 / Server 2019 Initial Setup Script - Tweak library
# Author: voltechs <dale@twilightcoders.net>
# Version: v1.00, 2020-09-25
# Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
##########

Function Install-Chocolatey() {
	$ChocoInstalled = Get-Command choco.exe -ErrorAction SilentlyContinue
	if (-Not $ChocoInstalled) {
		Write-Output "Installing Chocolatey..."
		Set-ExecutionPolicy Bypass -Scope Process -Force
		[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		Write-Output "Chocolatey Installed!"
	}
	
	Write-Output "Updating Chocolatey..."
	choco upgrade chocolatey
	Write-Output "Chocolatey Updated!"
}

Function SoftwareInstalled($name) {
	# https://keestalkstech.com/2017/10/powershell-snippet-check-if-software-is-installed/
	$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $name }) -ne $null
	return $installed
}

Function UnZipFile($path) {
	$filesystem = Expand-Archive -Path $path
	return $filesystem.FullPath
}

Function Choco-Install {
	ForEach ($PackageName in $Args)
	{
		Write-Output "Installing $Package!"
		choco install $PackageName -y
Function DownloadFile($url, $file) {
	$path = Join-Path $env:TEMP, $file
	Invoke-WebRequest "$url" -OutFile "$path"
	return $path
}

Function InstallEXEUrl($url, $name, $args, $force = $false) {
	if (SoftwareInstalled $name -or -Not $force) {
		return
	}

	$path = DownloadFile $url, "$name" + "Installer.exe"
	InstallEXEFile $path, $name, $args, $force
}

Function InstallEXEFile($file, $name, $args, $force = $false) {
	if (SoftwareInstalled $name -or -Not $force) {
		return
	}

	$i = 0
	#& "$file" /install;
	$process = New-Object System.Diagnostics.Process
	$process.StartInfo.FileName = "$file"
	$process.StartInfo.Arguments = $args
	$process.StartInfo.UseShellExecute = $false
	$process.StartInfo.RedirectStandardOutput = $true
	if ( $process.Start() ) {
		while(!$process.HasExited) {
			# $i++
			# DrawEllipsis "Installing $name" $i
			Start-Sleep -Milliseconds 500
		}
		$process.WaitForExit()
		rm "$file" -ErrorAction SilentlyContinue
	}
}

# Install XMeters
# Note: Installs the latest XMeters Client
Function Install-XMeters {
	InstallEXEUrl 'https://entropy6.com/xmeters/downloads/XMetersSetup.exe' 'XMeters' '/silent /install'
}

# Install Genie Timeline
# Note: Installs the latest Genie Timeline Client
Function Install-GenieTimeline {
	InstallEXEUrl 'http://downloads.genie9.com/gtl/GenieTimeline10Pro.exe' 'GenieTimeline' '/silent /install'
}

# Install Battle.net
# Note: Installs the latest Battle.net Client
Function Install-BattleNet {
	InstallEXEUrl 'https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP' 'BattleNet' '/silent /install'
}

# Install BCM94360CD
# Note: Installs the latest BCM94360CD Driver (from Apple/macOS)
Function Install-BCM94360CD {
	# Scrape https://support.apple.com/downloads/Bootcamp%2520Support
	# Find first link in grid (https://support.apple.com/kb/DL1837?viewlocale=en_US&locale=en_US)
	# Find URL for Download button (https://download.info.apple.com/Mac_OS_X/031-30890-20150812-ea191174-4130-11e5-a125-930911ba098f/bootcamp5.1.5769.zip)

	$file = DownloadFile 'https://download.info.apple.com/Mac_OS_X/031-30890-20150812-ea191174-4130-11e5-a125-930911ba098f/bootcamp5.1.5769.zip'
	$directory = UnZipFile $file
	$path = Join-Path "$directory" '$WinPEDriver$/AppleBluetoothBroadcom64/DPInst.exe'
	InstallEXEFile $path 'Broadcom Bluetooth Drivers (BCM94360CD)'
}
