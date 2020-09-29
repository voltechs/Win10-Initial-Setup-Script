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

Function InstallEXEUrl($url, $name, $args) {
	$LocalTempDir = $env:TEMP
    $exe = "$name" + "Installer.exe"
    (new-object System.Net.WebClient).DownloadFile($url, "$LocalTempDir\$exe")
    #& "$LocalTempDir\$exe" /install;
    $i = 0

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo.FileName = "$LocalTempDir\$exe"
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
        rm "$LocalTempDir\$exe" -ErrorAction SilentlyContinue
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
