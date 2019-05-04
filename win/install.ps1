#Requires -Version 3

# Prefer to use scoop, since it is open source and allows custom install folders.
# however, choco better supports installation flags such as git's "Open git bash here" functionality.
# I just gave up and used both. I'm sure there is going to be some situation down the line where they don't play nicely
# together, but not today.

# scoop installation
try {
	echo "downloading scoop"
	# NOTE: that everything in this try block is from https://get.scoop.sh, it has been modified to better support usage
	# within another script
	$old_erroractionpreference = $erroractionpreference
	$erroractionpreference = 'stop' # quit if anything goes wrong

	if(($PSVersionTable.PSVersion.Major) -lt 3) {
		Write-Output "PowerShell 3 or greater is required to run Scoop."
		Write-Output "Upgrade PowerShell: https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell"
		break
	}

	# show notification to change execution policy:
	if((Get-ExecutionPolicy) -gt 'RemoteSigned' -or (Get-ExecutionPolicy) -eq 'ByPass') {
		Write-Output "PowerShell requires an execution policy of 'RemoteSigned' to run Scoop."
		Write-Output "To make this change please run:"
		Write-Output "'Set-ExecutionPolicy RemoteSigned -scope CurrentUser'"
		break
	}

	if([System.Enum]::GetNames([System.Net.SecurityProtocolType]) -notcontains 'Tls12') {
		Write-Output "Scoop requires at least .NET Framework 4.5"
		Write-Output "Please download and install it first:"
		Write-Output "https://www.microsoft.com/net/download"
		break
	}

	# get core functions
	$core_url = 'https://raw.githubusercontent.com/lukesampson/scoop/master/lib/core.ps1'
	Write-Output 'Initializing...'
	Invoke-Expression (new-object net.webclient).downloadstring($core_url)

	# prep
	if(installed 'scoop') {
		write-host "Scoop is already installed. Run 'scoop update' to get the latest version." -f red
	}else {
		$dir = ensure (versiondir 'scoop' 'current')

		# download scoop zip
		$zipurl = 'https://github.com/lukesampson/scoop/archive/master.zip'
		$zipfile = "$dir\scoop.zip"
		Write-Output 'Downloading scoop...'
		dl $zipurl $zipfile

		Write-Output 'Extracting...'
		Add-Type -Assembly "System.IO.Compression.FileSystem"
		[IO.Compression.ZipFile]::ExtractToDirectory($zipfile,"$dir\_tmp")
		Copy-Item "$dir\_tmp\*master\*" $dir -Recurse -Force
		Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

		Write-Output 'Creating shim...'
		shim "$dir\bin\scoop.ps1" $false

		# download main bucket
		$dir = "$scoopdir\buckets\main"
		$zipurl = 'https://github.com/scoopinstaller/scoop-main/archive/master.zip'
		$zipfile = "$dir\main-bucket.zip"
		Write-Output 'Downloading main bucket...'
		New-Item $dir -Type Directory -Force | Out-Null
		dl $zipurl $zipfile

		Write-Output 'Extracting...'
		[IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$dir\_tmp")
		Copy-Item "$dir\_tmp\*-master\*" $dir -Recurse -Force
		Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

		ensure_robocopy_in_path
		ensure_scoop_in_path

		scoop config lastupdate ([System.DateTime]::Now.ToString('o'))
		success 'Scoop was installed successfully!'

		Write-Output "Type 'scoop help' for instructions."

		$erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value
	}

} catch {
	echo "scoop install error: " + $_.Exception.Message
	echo $_.Exception
}
$env:SCOOP_GLOBAL="D:/apps/scoop"
[environment]::setEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
scoop bucket add extras
scoop install -g python neovim msys2 vscode cmake git ag

# tell msys to use the windows path
$env:MSYS2_PATH_TYPE="inherit"
[environment]::setEnvironmentVariable('MSYS2_PATH_TYPE', $env:MSYS2_PATH_TYPE, "User")

function makeShortcut([string]$name, [string]$exe, [string]$icon = '') {
	$TargetFile = "$env:SCOOP_GLOBAL\shims\$exe"
	$ShortcutFile = "$env:Public\Desktop\$name.lnk"
	$WScriptShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
	$Shortcut.TargetPath = $TargetFile
	$Shortcut.Save()
}

# tell msys2 to inherit the full windows path
makeShortcut msys2 msys2_shell.cmd msys2.ico

pip install thefuck

