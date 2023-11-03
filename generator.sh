# Copyright Fabxx 2023 - Software Distributed under the General Public License V3 WITHOUT ANY GUARANTEE OR WARRANTY.

#!/bin/bash

# Info message for auto sort option

msg="moves roms into folders to generate start.sh per game. 2MB of free space is required.\n
If a game requires multiple files with different extensions (like duckstation with .bin and .cue), 
just rename the files with the same name and keep the extension as is.\n
These emulators don't need sorting and function can be skipped:\n
-Rpcs3 JB folder\n
-Xenia extracted files with default.xex\n
-Cxbx-r extracted files with default.xbe\n "

# Emulator Arguments

xemu_args="-full-screen -dvd_path"
xenia_args="--gpu vulkan"
pcsx2_args="-fullscreen"
mgba_args="-f"
dolphin_args="--config=Dolphin.Display.Fullscreen=True"
mupen_args="--fullscreen"
cemu_args="-f -g"
rpcs3_args="--no-gui"

# Wine DLL Overrides for PC games

# Current games that use the overrides: need for speed most wanted/carbon - splinter cell 1/Pandora tomorrow/Chaos Theory - Dirt/2/3/Showdown

NFSC_MW_OVERRIDE="*d3d9,*d3d10,*d3d10_1,*d3d10core,*d3d11,*dxgi=b"

SC_SCPT_OVERRIDE="*d3d8, *msacm32, *msvfw32=n,b"

SCCT_OVERRIDE="*d3d9, *msacm32, *msvfw32=n,b"

DIRT_2_3_SH_OVERRIDE="*openal32=n,b"

# PC Games arguments

# Current Arguments: Colin McRae Rally 2005 - Kingdom Come Deliverance - Splinter Cell Chaos Theory

CMR2005="FORCEHT WIDESCREENDISPLAY NOVIDEO"

KINGDOMDEV="-devmode"

SCCT_SKIP_VIDEO="-nointro"

# Rom sorter.

SortRoms()
{
	zenity --question --text="sort roms into folders? If you don't know how it works please check AutoSort info in the main menu."
	
	if [[ $? == 1 ]]; then Parser
	fi

	# Check disk space
	minDiskSpace=2M
	freeDiskSpace=$(df --output=avail -BM "$path_games" | tail -n 1)

	if [[ $freeDiskSpace < 2 ]]; then 
	zenity --error --text="Not enough space on disk to create folders! The Parser cannot sort the files"
	ZenityUI
	fi

	# FInd all files that can match the extension.
	cd "$path_games"
	
	files=()
       
	readarray -t files < <(ls *.3ds *.app *.bin *.cia *.cue *.dsi *.dol *.ecm *.elf *.gb *.gba \
		       *.gbc *.gcz *.ids *.img *.iso *.jpeg *.jpg *.n64 *.nds *.nsp *.png \
		       *.rvz *.sbi *.sfc *.smc *.v64 *.wad *.wbfs *.wud *.wux *.xci *.z64 *.zar)

	indexdirs=0 indexfiles=0

	for i in "${files[@]%.*}"; do mkdir "$i"; done

	subdirs=(*/)

	while [[ $indexfiles -lt ${#files[@]} ]]

		do
			if [[ "${files[$indexfiles]%.*}" == "${subdirs[$indexdirs]%/*}" ]]; then
				mv "${files[$indexfiles]}" "${subdirs[$indexdirs]}";
				((indexfiles++))
				indexdirs=0
			else
				((indexdirs++))
			fi
	done
}

# Parser

Parser()
{

	for folder in "$path_games"/*; do cd "$folder";

	echo -e "#!/bin/bash" "\n" > start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e "cd \"$(pwd)\"\n" >> start.sh

	case $parserList in

	1) 
		case $parser_ID in

		1) #duckstation
		echo -n \""$path_executable"\" "" \""$(ls *.cue *.iso *.img *.ecm)"\" >> start.sh
		;;
		
		2) #pcsx2
		echo -n \""$path_executable"\" "" \""$(ls *.iso)"\" "" "$pcsx2_args" >> start.sh
		;;
		
		3) #ppsspp
		echo -n \""$path_executable"\" "" \""$(ls *.iso)"\" >> start.sh
		;;

		4) #rpcs3 JB format
		echo -n \""$path_executable"\" "" "$rpcs3_args" \""$(ls PS3_GAME/USRDIR/EBOOT.BIN)"\" >> start.sh
		;;

		esac
		;;

	
	2)
		case $parser_ID in
	
		1) #citra
		echo -n \""$path_executable"\" "" \""$(ls *.3ds *.cia)"\" >> start.sh
		;;
		
		2) #melonDS
		echo -n \""$path_executable"\" "" \""$(ls *.nds *.dsi *.ids *.app)"\" >> start.sh
		;;
		
		3) #Yuzu/Ryujinx
		echo -n \""$path_executable"\" "" \""$(ls *.nsp *.xci)"\" >> start.sh
		;;
		
		4) #mGBA
		echo -n \""$path_executable"\" "" "$mgba_args" "" \""$(ls *.gba *.gbc *.gb)"\" >> start.sh
		;;

		5) #mupen64
		echo -n \""$path_executable"\" "" \""$(ls *.z64 *.v64 *.n64)"\" "$mupen_args" >> start.sh
		;;
		
		6) #snes9x
		echo -n \""$path_executable"\" "" \""$(ls *.smc *.sfc)"\" >> start.sh
		;;

		7) #Cemu
		echo -n \""$path_executable"\" "" "$cemu_args" \""$(ls *.wud *.wux)"\" >> start.sh
		;;

		8) #Dolphin
		echo -n \""$path_executable"\" "" "--exec=\""$(ls *.wbfs *.wad *.iso *.gcz *.rvz *.dol *.elf)"\"" "$dolphin_args" >> start.sh
		;;

		esac
		;;
		
	3)
		case $parser_ID in

	
		1) #Xemu
		echo -n \""$path_executable"\" "" "$xemu_args" "" \""$(ls *.iso)"\" >> start.sh
		;;
		
		2) #Xenia
	    echo -n wine \""$path_executable"\" "" \""$(ls *.xex *.iso *.zar)"\" >> start.sh
		;;

		3) #cxbx-r
		echo -n wine \""$path_executable"\" "" \""$(ls *.xbe)"\" >> start.sh
		;;

		esac
		;;

	
	4)
		case $parser_ID in

		1) #Wine
		# List of games that use the DLLOVERRIDES in the script. 
		#NOTE: If you renamed your game folder that is in this list, please rename the folder names here to match your folder names.  

		if [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell" ]; then 

			echo -n WINEDLLOVERRIDES=\""$SC_SCPT_OVERRIDE"\" >> start.sh 

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell Pandora Tomorrow" ]; then 

			echo -n WINEDLLOVERRIDES=\""$SC_SCPT_OVERRIDE"\" >> start.sh

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell Chaos Theory" ]; then
		
			echo -n WINEDLLOVERRIDES=\""$SCCT_OVERRIDE"\" >> start.sh

		elif [ "$(pwd)" == "$path_games/Need For Speed Carbon" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$NFSC_MW_OVERRIDE"\" >> start.sh

		elif [ "$(pwd)" == "$path_games/Need For Speed Most Wanted 2005" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$NFSC_MW_OVERRIDE"\" >> start.sh 

		elif [ "$(pwd)" == "$path_games/DiRT 2" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$DIRT_2_3_SH_OVERRIDE"\" >> start.sh 

		elif [ "$(pwd)" == "$path_games/DiRT 3 Complete Edition" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$DIRT_2_3_SH_OVERRIDE"\" >> start.sh

		elif [ "$(pwd)" == "$path_games/Colin McRae DiRT" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$DIRT_2_3_SH_OVERRIDE"\" >> start.sh

		elif [ "$(pwd)" == "$path_games/DiRT Showdown" ]; then 
		
			echo -n WINEDLLOVERRIDES=\""$DIRT_2_3_SH_OVERRIDE"\" >> start.sh 

		elif [ "$(pwd)" == "$path_games/Blur" ]; then

			zenity --info --text="Specific game Blur detected, please choose a dedicated prefix folder for this game"

			blurPrefix=" "

			while [ "$blurPrefix" == " " ]
			do
				blurPrefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
				if [ $? == 1 ]; then ZenityUI
				fi

				partitionType=$(stat -f -c %T "$blurPrefix")

				if [[ "$partitionType" != *"ext"* ]]; then

				zenity --error --text="Partition type is "$partitionType", but must be EXT format"
				blurPrefix=" "
				fi
			done

			WINEPREFIX="$blurPrefix" wineboot
			WINEPREFIX="$blurPrefix" winetricks -q vcrun2019 dxvk1030
			echo -n WINEPREFIX=\""$blurPrefix"\" "" >> start.sh
		
		elif [ "$(pwd)" == "$path_games/Saints Row 2" ]; then
			
			zenity --info --text="Specific game Saints Row 2 detected, choose a dedicated prefix folder for this game"

			sr2Prefix=" "

			while [ "$sr2Prefix" == " " ]
			do
				sr2Prefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
				if [ $? == 1 ]; then ZenityUI
				fi

				partitionType=$(stat -f -c %T "$sr2Prefix")

				if [[ "$partitionType" != *"ext"* ]]; then

				zenity --error --text="Partition type is "$partitionType", but must be EXT format"
				sr2Prefix=" "
				fi
			done

			WINEPREFIX="$sr2Prefix" wineboot
			WINEPREFIX="$sr2Prefix" winetricks -q vcrun2019 dxvk xact
			echo -n WINEPREFIX=\""$sr2Prefix"\" "" >> start.sh
		
		elif [ "$(pwd)" == "$path_games/Test Drive Unlimited 2" ]; then
			
			zenity --info --text="Specific game Test Drive Unlimited 2 detected, choose a dedicated prefix folder for this game"

			tdu2Prefix=" "

			while [ "$tdu2Prefix" == " " ]
			do
				tdu2Prefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
				if [ $? == 1 ]; then ZenityUI
				fi

				partitionType=$(stat -f -c %T "$tdu2Prefix")

				if [[ "$partitionType" != *"ext"* ]]; then

				zenity --error --text="Partition type is "$partitionType", but must be EXT format"
				tdu2Prefix=" "
				fi
			done

			WINEPREFIX="$tdu2Prefix" wineboot
			WINEPREFIX="$tdu2Prefix" WINEARCH=win32 winetricks -q dotnet40 dxvk1103 ie7 dinput8 directplay
			echo -n WINEPREFIX=\""$tdu2Prefix"\" WINEARCH=win32 "" >> start.sh
			
		fi

		# reach the exe located in subdirs or add arguments for some specific games. Here is a list of the games i've encountered so far.

		if   [ "$(pwd)" == "$path_games/Colin McRae Rally 2005" ]; then echo -n "" wine "$(ls *.exe)" "$CMR2005" >> start.sh

		elif [ "$(pwd)" == "$path_games/Borderlands" ]; then echo -n "" wine "$(ls Binaries/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Borderlands 2" ]; then echo -n "" wine "$(ls Binaries/Win32/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Borderlands - The Pre-Sequel" ]; then echo -n "" wine "$(ls Binaries/Win32/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/BioShock Remastered" ]; then echo -n "" wine "$(ls Build/Final/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/BioShock 2 Remastered" ]; then echo -n "" wine "$(ls Build/Final/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/BioShock Infinite - The Complete Edition" ]; then echo -n "" wine "$(ls Binaries/Win32/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Far Cry 3 - Duology" ]; then echo -n "" wine "$(ls FarCry3/bin/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Mafia II" ]; then echo -n "" wine "$(ls pc/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Mirror's Edge" ]; then echo -n "" wine "$(ls Binaries/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Sniper Elite 3" ]; then echo -n "" wine "$(ls bin/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Spider Man Web of Shadows" ]; then echo -n "" wine "$(ls image/pc/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/THIEF - Definitive Edition" ]; then echo -n "" wine "$(ls Binaries2/Win64/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell" ]; then echo -n "" wine "$(ls system/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell Pandora Tomorrow" ]; then echo -n "" wine "$(ls offline/system/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell Chaos Theory" ]; then echo -n "" wine "$(ls System/*.exe)" "$SCCT_SKIP_VIDEO" >> start.sh

		elif [ "$(pwd)" == "$path_games/Tom Clancys Splinter Cell Conviction" ]; then echo -n "" wine "$(ls src/system/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Unreal Tournament 3" ]; then echo -n "" wine "$(ls Binaries/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Watch Dogs" ]; then echo -n "" wine "$(ls bin/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Watch Dogs 2" ]; then echo -n "" wine "$(ls bin/*.exe)" >> start.sh

		elif [ "$(pwd)" == "$path_games/Kingdom Come Deliverance" ]; then echo -n "" wine "$(ls bin/Win64/*.exe)" "$KINGDOMDEV" >> start.sh

		# if the exe isn't in subdirs and doesn't require any arguments fallback to default string.

		else echo wine \""$(ls *.exe)"\" >> start.sh

		fi
		;;

		esac
		;;
	
	*)

   esac
	
   cd ..;
   done;

   zenity --info --text="Script generation complete"
   ZenityUI
}

ZenityUI()
{
	# Categories

	parserList=$(zenity --list --text="Select a category" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
	1 "Sony"   	        "Emulators" \
	2 "Nintendo" 	    "Emulators" \
	3 "Microsoft"       "Emulators" \
	4 "PC Games"   		"Wine" \
	5 "Information"      "Show autoSort info")

	if [ $? == 1 ]; then exit;
	fi

	case $parserList in

		1)
			parser_ID=$(zenity --list --text="Select a Parser" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
			1 Duckstation  "PS1 Emulator" \
			2 Pcsx2   	   "PS2 Emulator" \
			3 Ppsspp  	   "PSP Emulator" \
			4 Rpcs3		   "PS3 Emulator" )

			if [ $? == 1 ]; then ZenityUI;
			fi
			;;

		2)
			parser_ID=$(zenity --list --text="Select a Parser" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
			1 Citra   	   "Nintendo 3DS Emulator" \
			2 melonDS 	   "Nintendo DS Emulator" \
			3 Yuzu/Ryujinx "Nintendo Switch Emulator" \
			4 mGBA    	   "Gameboy Advance Emulator" \
			5 mupen64	   "Nintendo 64 Emulator" \
			6 snes9x	   "Super nintendo emulator" \
			7 Cemu		   "Nintendo Wii U emulator" \
			8 dolphin      "Nintendo Wii/Gamecube emulator" )

			if [ $? == 1 ]; then ZenityUI;
			fi
			;;
		
		3)
			parser_ID=$(zenity --list --text="Select a Parser" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
			1 Xemu    	   "Original Xbox Emulator" \
			2 Xenia   	   "Xbox 360 Emulator" \
			3 Cxbx-r	   "Original Xbox Emulator" )

			if [ $? == 1 ]; then ZenityUI;
			fi
			;;
	
		4)
			parser_ID=$(zenity --list --text="Select a Parser" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
			1 Wine 	   		 				"Windows .exe games (default prefix)" \ )

			if [ $? == 1 ]; then ZenityUI;
			fi
			;;
		5)
			zenity --info --ellipsize --text="$msg"
			ZenityUI
			;;
	esac

	if [ $? == 1 ]; then ZenityUI
	fi

	# Wine uses default prefix.
	if [[ $parserList == 4 && $parser_ID == 1 ]]; then


	if [[ $winePresent != 0 || $winetricksPresent != 0 ]]; then 
	zenity --error --text="You must install wine and winetricks to run this parser!"
	ZenityUI
	
	else
	zenity --info --text="Using default prefix, executing wineboot and winetricks commands"
	wineboot
	winetricks -q vcrun2019 dxvk vkd3d
	fi
	fi

	
	# Xenia canary requires wine. (until linux build works)

	if [[ $parserList == 3 && $parser_ID == 2 ]]; then
	
	zenity --info --text="Using default prefix, executing wineboot and winetricks commands"
	wineboot
	winetricks -q vcrun2019 dxvk vkd3d
	
	fi

	# Always ask for emulator executable if not using wine
	if [[ $parserList != 4 ]]; then
	zenity --info --text="Select the emulator executable"
	path_executable=$(zenity --title="Select emulator executable" --file-selection)

	if [ $? == 1 ]; then ZenityUI
	fi
	fi


	#Always ask for ROM directory
	zenity --info --text="Select the ROM's directory"
	path_games=$(zenity --title="Select ROM's path" --directory --file-selection)
	if [ $? == 1 ]; then ZenityUI
	fi

	# TODO do not ask to sort if not using compact rom files. rom files must be single compressed format.

	SortRoms
 	Parser
	
}

# Detect available UI selection interfaces. type returns 0 if command is available, 1 if not.

type zenity >> /dev/null
zenityPresent=$?

type winetricks >> /dev/null
winetricksPresent=$?

type wine >> /dev/null
winePresent=$?

# Check if needed components are available

if [ $zenityPresent != 0 ]; then

echo "Zenity must be installed in your system to display UI." 
exit

elif [[ $winePresent != 0 || $winetricksPresent != 0 ]]; then 

zenity --info --text="Consider installing wine and winetricks to use PC parser"

fi

ZenityUI
