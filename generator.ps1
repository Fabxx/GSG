# Emulator Arguments 

$xemu_args="-full-screen -dvd_path"
#$xenia_args="--gpu vulkan"
$pcsx2_args="-fullscreen"
$mgba_args="-f"
$dolphin_args="--config=Dolphin.Display.Fullscreen=True"
#$mupen_args="--fullscreen"
$cemu_args="-f -g"
$rpcs3_args="--no-gui"

# MAIN UI CODE

Function interface() {

	Clear-Host

# force the while loop checks and XBMC check
$parserList = 14

$parserID = 14

Write-Host "Categories:" -ForegroundColor White
Write-Host "1 Sony               Emulators" -ForegroundColor DarkCyan
Write-Host "2 Nintendo           Emulators" -ForegroundColor DarkRed
Write-Host "3 Microsoft          Emulators" -ForegroundColor Green
Write-Host "4 PC Games           Windows .exe" -ForegroundColor DarkYellow
Write-Host "5 Information        Show autoSort info" -ForegroundColor Gray
Write-Host "0 Exit" -ForegroundColor White


while (($parserList -lt 0) -or ($parserList -gt 5)) {
	
	[int]$parserList = Read-Host "Select category of games (0-5)"

	if ($parserList -eq 0) {
		exit
	}
}

switch ($parserList) {
	
1 {
	Clear-Host
	
	Write-Host "0)  Menu" -ForegroundColor White
	Write-Host "1)  Duckstation" -ForegroundColor DarkYellow
	Write-Host "2)  Pcsx2" -ForegroundColor DarkBlue
	Write-Host "3)  Ppsspp" -ForegroundColor DarkCyan
	Write-Host "4)  Rpcs3" -ForegroundColor DarkMagenta
	
		

		while (($parserID -lt 0) -or ($parserID -gt 4)) {
		
			[int]$parserID = Read-Host "Select an option (0-4)"

			if ($parserID -eq 0) {
				interface
			}
		}
	
	}
	
2 {
	Clear-Host
	
	Write-Host "0 Menu" -ForegroundColor White
	Write-Host "1 Citra          Nintendo 3DS Emulator" -ForegroundColor Yellow
	Write-Host "2 melonDS        Nintendo DS Emulator" -ForegroundColor Green
	Write-Host "3 Yuzu/Ryujinx   Nintendo Switch Emulator" -ForegroundColor DarkRed
	Write-Host "4 mGBA           Gameboy Advance Emulator" -ForegroundColor Magenta
	Write-Host "5 mupen64        Nintendo 64 Emulator" -ForegroundColor DarkGray
	Write-Host "6 snes9x         Super Nintendo Emulator" -ForegroundColor DarkRed
	Write-Host "7 Cemu           Nintendo Wii U Emulator" -ForegroundColor DarkCyan
	Write-Host "8 dolphin        Nintendo Wii/Gamecube Emulator" -ForegroundColor DarkMagenta
	

	while (($parserID -lt 0) -or ($parserID -gt 8)) {
		
			[int]$parserID = Read-Host "Select an option (0-8)"

			if ($parserID -eq 0) {
				interface
			}
		}
	}
	
3 {
	Clear-Host
	Write-Host "0 Menu" -ForegroundColor White
	Write-Host "1 Xemu           Original Xbox Emulator" -ForegroundColor DarkGreen
	Write-Host "2 Xenia          Xbox 360 Emulator" -ForegroundColor Green
	Write-Host "3 Cxbx-r         Original Xbox Emulator" -ForegroundColor DarkYellow
	

	while (($parserID -lt 0) -or ($parserID -gt 3)) {
			
				[int]$parserID = Read-Host "Select an option (0-3)"
			}

			if ($parserID -eq 0) {
				interface
			}
	}
	
4 {
	Clear-Host
	Write-Host "0 Menu" -ForegroundColor White
	Write-Host "1 Windows Executables" -ForegroundColor DarkCyan
	
	
		while (($parserID -lt 0) -or ($parserID -gt 1)) {
					
			[int]$parserID = Read-Host "Select an option (0-1)"

			if ($parserID -eq 0) {
				interface
			}
		}
	  }
	}	

$isXbmcscript = -1

while ( ($isXbmcscript -ne 1) -and ($isXbmcscript -ne 0) ) {
	
    [int]$isXbmcscript = Read-Host "Will you use these scripts with XBMC? Type 1 for yes or 0 for no"
}

if ($isXbmcscript -eq 1) {
	$xbmcExecutable = Read-Host "Write absolute path of XBMC, including XBMC.exe"
}


# Let user select game folder

$path = Read-Host "Insert the absolute path of the games folder."

# get all subdirs in folder.

$subdirs =  Get-ChildItem -Path $path -Directory | Select-Object -ExpandProperty Name


# if user has not selected windows category, let him choose emulator executable

if ($parserList -ne 4) {
	
		$emulator = Read-Host "Put absolute path of emulator executable, with also the .exe name and extension"
		$emuPath = $(Get-Item $emulator).DirectoryName
	}
	parser
}

Function parser() {
	
	foreach ($folder in $subdirs) {

	 Set-Location $path\$folder
		
			switch ($parserList) {
		
				1 {
					switch ($parserID) {
						
					# NOTE: Working directory argument is optional. TargetPath and Arguments are what matters the most.
					1 {
						# Duckstation
						 $game = $(Get-Item *.cue,*.iso,*.img,*.ecm,*.chd).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = "`"$game`" " # write argument with double quotes by escaping them.
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					2 {
						# PCSX2
						 $game = $(Get-Item *.iso,*.chd).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" `"$pcsx2_args`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					3 {
						# PPSSPP
						 $game = $(Get-Item *.iso).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					4 {
						# RPCS3
						 $childItem = $(Get-ChildItem -Recurse -Name | Where-Object {$_ -clike "*EBOOT.BIN"} -ErrorAction 'SilentlyContinue'  )
						 $game = $(Get-Item $ChildItem).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" `"$rpcs3_args`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
				}
			}
			
				2 {
					switch ($parserID) {
					1 {
						# Citra
						 $game = $(Get-Item *.cia,*.3ds).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					2 {
						# MelonDS
						 $game = $(Get-Item *.nds).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					3 {
						# Yuzu/Ryujinx
						 $game = $(Get-Item *.xci,*.nsp).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					4 {
						# mGBA
						 $game = $(Get-Item *.gba,*.gbc,*.gb).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					5 {
						# mupen64
						 $game = $(Get-Item *.z64,*.v64,*.n64).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" `"$mgba_args`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					6 {
						# snes9x
						 $game = $(Get-Item *.smc,*.sfc).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					7 {
						# Cemu
						 $game = $(Get-Item *.wud,*.wux).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" `"$cemu_args`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					8 {
						# Dolphin
					     $game = $(Get-Item *.wbfs,*.wad,*.iso,*.gcz,*rvz,*.dol,*.elf).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" `"$dolphin_args`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
				}				
			}
			
			3 {
				switch ($parserID) {
					
					1 {
						# Xemu
						 $game = $(Get-Item *.iso).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$xemu_args`" `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					2 {
						# Xenia
						 $game = $(Get-Item *.xex,*.zar,*.iso).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
					
					3 {
						# Cxbx-r 
						 $game = $(Get-Item *.xbe).FullName
						 $WshShell = New-Object -comObject WScript.Shell
						 $Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						 $Shortcut.TargetPath = $emulator
						 $Shortcut.Arguments = " `"$game`" "
						 $Shortcut.WorkingDirectory = $emuPath
						 $Shortcut.Save()
					}
				}
			}
			
			4 {
				switch ($parserID) {
					
					1 {
						# Windows .exe
						$tmpExe = Get-ChildItem -Path "$path\$folder" -File -Recurse | Where-Object { $_.Extension -ceq ".EXE" } | Select-Object -ExpandProperty FullName
						$exeFolder = $tmpExe.DirectoryName
						
						$WshShell = New-Object -comObject WScript.Shell
						$Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
						$Shortcut.TargetPath = "$tmpExe"
						$Shortcut.WorkingDirectory = "$exeFolder"
						$Shortcut.Save()	
					}
				
				}
			}
		}
		
		if ($isXbmcscript -eq 1) {
			xbmcScriptGen
		}

		Write-Output $(Get-Location)
		Set-Location ..
	}

	Write-Host "Scan Complete! Returning to main menu."
	Start-Sleep 3
	interface
}

Function xbmcScriptGen() {

	# Create empty powershell file to write script.

	"" | Out-File -FilePath $path\$folder\Xbmc.ps1

if (($parserList -eq 4) -and ($parserID -eq 1)) {
		
			
$xbmcScript = @"
		
while (`$true) {

	if (!`$(Get-Process $exeName)) {
		cd '$xbmcPath'; .\XBMC.exe
		break
	}

Start-Sleep -Seconds 3.0
}
"@		
	} else{
		
$emulatorProcName = $(get-Item $emulator).Basename

$xbmcScript = @"
		
while (`$true) {

	if (!`$(Get-Process $emulatorProcName)) {
		cd '$xbmcPath'; .\XBMC.exe
		break
	}

Start-Sleep -Seconds 3.0
}
"@		
	}
	
	Add-Content $path\$folder\Xbmc.ps1 $xbmcScript
}


interface
parser


	



