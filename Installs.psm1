##########
# Win 10 / Server 2016 / Server 2019 Initial Setup Script - Tweak library
# Author: voltechs <dale@twilightcoders.net>
# Version: v1.00, 2020-09-25
# Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
##########


Function DrawEllipsis($message = "Processing", $i) {
#Write-Output $message
	$i = $i % 3
	$dots = "."
	for($i--; $i -gt 0; $i--) {
		$dots = $dots + "."
	}
	Write-Progress -Activity "$message" -Status "$dots"
}

Function SoftwareInstalled($name) {
	# https://keestalkstech.com/2017/10/powershell-snippet-check-if-software-is-installed/
	$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $name }) -ne $null
	return $installed
}

Function DownloadFile($url, $file) {
	$path = Join-Path $env:TEMP, $file
	Invoke-WebRequest "$url" -OutFile "$path"
	return $path
}

Function InstallEXEUrl($url, $name, $args, $force = $false) {
	if (SoftwareInstalled $name -or -Not $force) {
		return
	}

	$file = $env:TEMP + "\" + "$name" + "Installer.exe"
	Invoke-WebRequest $url -OutFile "$file"
	InstallEXEFile $file, $name, $args, $force
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
			$i++
			DrawEllipsis "Installing $name" $i
			Start-Sleep -Milliseconds 500
		}
		$process.WaitForExit()
		rm "$file" -ErrorAction SilentlyContinue
	}
}

# Install Google Chrome
# Note: Installs the latest Google Chrome
Function Install-GoogleChrome {
	InstallEXEUrl 'https://dl.google.com/chrome/chrome_installer.exe' 'Chrome' '/install'
}

# Install Discord
# Note: Installs the latest Discord Client
Function Install-Discord {
	InstallEXEUrl 'https://discord.com/api/download?platform=win' 'Discord' '/s'
}

# Install Origin
# Note: Installs the latest Origin Client
Function Install-Origin {
	# Requires https://www.microsoft.com/en-gb/download/confirmation.aspx?id=48145&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1
	InstallEXEUrl 'https://www.dm.origin.com/download' 'Origin' '/install'
}

# Install WeMod
# Note: Installs the latest WeMod Client
Function Install-WeMod {
	InstallEXEUrl 'https://www.wemod.com/download/direct' 'WeMod' '/install'
}

# Install Slack
# Note: Installs the latest Slack Client
Function Install-Slack {
	InstallEXEUrl 'https://slack.com/ssb/download-win64' 'Slack' '/install'
}

# Install Steam
# Note: Installs the latest Steam Client
Function Install-Steam {
	InstallEXEUrl 'https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe' 'Steam' '/silent /install'
}

# Install WinDirStat
# Note: Installs the latest WinDirStat Client
Function Install-WinDirStat {
	InstallEXEUrl 'https://windirstat.mirror.wearetriple.com/wds_current_setup.exe' 'WinDirStat' '/silent /install'
}

# Install SidebarDiagnostics
# Note: Installs the latest SidebarDiagnostics Client
Function Install-SidebarDiagnostics {
	# TODO: Scrape Latest Release (use API)
	InstallEXEUrl 'https://github.com/ArcadeRenegade/SidebarDiagnostics/releases/download/3.5.6/Setup.exe' 'SidebarDiagnostics' '/silent /install'
}

# Install 7Zip
# Note: Installs the latest 7Zip Client
Function Install-7Zip {
	InstallEXEUrl 'https://www.7-zip.org/a/7z1900-x64.msi' '7zip' '/qb'
}

# Install XMeters
# Note: Installs the latest XMeters Client
Function Install-XMeters {
	InstallEXEUrl 'https://entropy6.com/xmeters/downloads/XMetersSetup.exe' 'XMeters' '/silent /install'
}

# Install 1Password7
# Note: Installs the latest 1Password7 Client
Function Install-1Password7 {
	InstallEXEUrl 'https://app-updates.agilebits.com/download/OPW7' '1Password7' '/silent /install'
}

# Install Dropbox
# Note: Installs the latest Dropbox Client
Function Install-Dropbox {
	InstallEXEUrl 'https://www.dropbox.com/download?os=win' 'Dropbox' '/silent /install'
}

# Install UPlay
# Note: Installs the latest UPlay Client
Function Install-UPlay {
	InstallEXEUrl 'https://ubistatic3-a.akamaihd.net/orbit/launcher_installer/UplayInstaller.exe' 'UPlay' '/silent /install'
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

# Install StartIsBack
# Note: Installs the latest StartIsBack Client
Function Install-StartIsBack {
	InstallEXEUrl 'https://s3.amazonaws.com/startisback/StartIsBackPlusPlus_setup.exe' 'StartIsBack' '/silent /install'
}

# Install Nextcloud
# Note: Installs the latest Nextcloud Client
Function Install-Nextcloud {
	InstallEXEUrl 'https://download.nextcloud.com/desktop/releases/Windows/latest' 'Nextcloud' '/silent /install'
}

# Install PowerToys
# Note: Installs the latest PowerToys Client
Function Install-PowerToys {
	InstallEXEUrl 'https://github.com/microsoft/PowerToys/releases/download/v0.21.1/PowerToysSetup-0.21.1-x64.msi' 'PowerToys' '/silent /install'
}
