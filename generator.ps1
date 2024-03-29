# Emulator Arguments 

$xemu_args="-full-screen -dvd_path"
$xenia_args="--gpu vulkan"
$pcsx2_args="-fullscreen"
$mgba_args="-f"
$dolphin_args="--config=Dolphin.Display.Fullscreen=True"
$mupen_args="--fullscreen"
$cemu_args="-f -g"
$rpcs3_args="--no-gui"

# PC Games arguments

$CMR2005="FORCEHT WIDESCREENDISPLAY NOVIDEO"

$KINGDOMDEV="-devmode"

$SCCT_SKIP_VIDEO="-nointro"


# MAIN UI CODE

Function interface() {

# force the while loop checks and XBMC check
$parserList = 14

$parserID = 14

$isXbmcscript = -1

@"
Categories:
1 Sony  	 	Emulators 
2 Nintendo 	 	Emulators
3 Microsoft     Emulators
4 PC Games   	Windows .exe
5 Information   Show autoSort info
0 Exit
"@

while (($parserList -lt 0) -or ($parserList -ge 5)) {
	
	[int]$parserList = Read-Host "Select category of games (0-5)"
}

if ($parserList -eq 0) {
	Exit
}


switch ($parserList) {
	
1 {
@"
1)	Duckstation
2)	Pcsx2
3)	Ppsspp
4)	Rpcs3
"@
	
		while (($parserID -lt 1) -or ($parserID -ge 4)) {
		
			[int]$parserID = Read-Host "Select a parser (1-4)"
		}
	
	}
	
2 {
@"
1 Citra   	   Nintendo 3DS Emulator
2 melonDS 	   Nintendo DS Emulator
3 Yuzu/Ryujinx 	   Nintendo Switch Emulator
4 mGBA    	   Gameboy Advance Emulator
5 mupen64	   Nintendo 64 Emulator
6 snes9x	   Super nintendo emulator
7 Cemu		   Nintendo Wii U emulator
8 dolphin          Nintendo Wii/Gamecube emulator
"@

	while (($parserID -lt 1) -or ($parserID -ge 8)) {
		
			[int]$parserID = Read-Host "Select a parser (1-8)"
		}
	}
	
3 {
@"
1 Xemu    	   Original Xbox Emulator
2 Xenia   	   Xbox 360 Emulator
3 Cxbx-r	   Original Xbox Emulator
"@
	while (($parserID -lt 1) -or ($parserID -ge 3)) {
			
				[int]$parserID = Read-Host "Select a parser (1-3)"
			}
	}
	
4 {
@"
1 Windows Executables
"@
	while (($parserID -lt 1) -or ($parserID -ge 1)) {
			
				[int]$parserID = Read-Host "Select a parser (1)"
			}
		}
		
	}


while ( ($isXbmcscript -ne 1) -and ($isXbmcscript -ne 0) ) {
	
    [int]$isXbmcscript = Read-Host "Will you use these scripts with XBMC? Type 1 for yes or 0 for no"
}

if ($isXbmcscript -eq 1) {
	$xbmcExecutable = Read-Host "Write absolute path of XBMC, including XBMC.exe"
}


# Let user select game folder

$path = Read-Host "Insert the absolute path of the games folder."

# get all subdirs in folder.

$subdirs = Get-ChildItem -Path $path -Directory


# if user has not selected windows category, let him choose emulator executable

if ($parserList -ne 4) {
	
		$emulator = Read-Host "Put absolute path of emulator executable, with also the .exe name and extension"
		$emuPath = $(Get-Item $emulator).DirectoryName
	}
	
	parser
}



Function parser() {
	
	foreach ($folder in $subdirs) {

	 cd $path\$folder
		
			switch ($parserList) {
		
				1 {
					switch ($parserID) {
			
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
						 $childItem = $(Get-ChildItem -Recurse -Name | where {$_ -clike "*EBOOT.BIN"} -ErrorAction 'SilentlyContinue'  )
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
						 $Shortcut.Arguments = " `"$xemu_args`"`"$game`" "
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
						$tmpExe = $(Get-Item *.exe).FullName
						$exePath = $(Get-Item $tmpExe).Directory
						$exeName = $(Get-Item $tmpExe).Basename
						
						if ( "$(pwd)" -eq "$path\Colin McRae Rally 2005" ) {
							
							$WshShell = New-Object -comObject WScript.Shell
							$Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
							$Shortcut.TargetPath = $tmpExe
							$Shortcut.Arguments = " `"$CMR2005`" "
							$Shortcut.WorkingDirectory = $exePath
							$Shortcut.Save()
						} else {
							$tmpExe = $(Get-Item *.exe).FullName
							$WshShell = New-Object -comObject WScript.Shell
							$Shortcut = $WshShell.CreateShortcut("$path\$folder\$folder.lnk")
							$Shortcut.TargetPath = $tmpExe
							$Shortcut.WorkingDirectory = $exePath
							$Shortcut.Save()
						}
					}
				
				}
			}
		}
		
		if ($isXbmcscript -eq 1) {
			xbmcScriptGen
		}

		echo $(pwd)
		cd ..
	}
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


	



