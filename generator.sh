#!/bin/bash

# TODO: check if disk is NTFS, exFAT or FAT32. do NOT ALLOW a prefix creation in these.

# Emulator Arguments

xemu_args="-full-screen -dvd_path"
xenia_args="--gpu vulkan"
pcsx2_args="-fullscreen"
mgba_args="-f"

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


# Parsers

citraParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" > start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all extensions in each folder. So a single match is guaranteed

	echo -n \""$path_executable"\" "" \""$(ls *.cia *.3ds)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}


melonDSParse()
{

	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	echo -n \""$path_executable"\" "" \""$(ls *.nds *.dsi *.ids *.app)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}

mGBAParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all 3 extensions in each folder. So a single match is guaranteed

	echo -n \""$path_executable"\" "" "$mgba_args" "" \""$(ls *.gba *.gbc *.gb)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}


XemuParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	echo -n \""$path_executable"\" "" "$xemu_args" "" \""$(ls *.iso)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}


XeniaParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all extensions in each folder. So a single match is guaranteed

	echo -n wine \""$path_executable"\" "" \""$(ls *.xex *.iso})"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI

}

PpssppParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all 3 extensions in each folder. So a single match is guaranteed

	echo -n \""$path_executable"\" "" \""$(ls *.iso)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}


Pcsx2Parse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	echo -n \""$path_executable"\" "" \""$(ls *.iso)"\" "" "$pcsx2_args" >> start.sh


	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}

DuckstationParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all 3 extensions in each folder. So a single match is guaranteed

	echo -n \""$path_executable"\" "" \""$(ls *.cue *.iso *.img)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}

YuzuRyujinxParse()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo $(pwd); #show if goes into the folders successfully.

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	# Don't worry if in some folders it says "file not found", because it tires to parse all extensions in each folder. So a single match is guaranteed

	echo -n \""$path_executable"\" "" \""$(ls *.nsp *.xci)"\" >> start.sh

	cd ..;

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}

WineParseGeneric()
{
	for folder in "$path_games"/*; do cd "$folder";

	echo $(pwd); #show if goes into the folders successfully.

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh
	
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

	cd ..

	done;

	zenity --info --text="Script generation complete"

	ZenityUI
}

# Specific Games parsers, used fo those games that require specific winetricks configurations.

tdu2Parser()
{
	for folder in "$path_games"/*; do cd "$folder";	

	if [ "$(pwd)" == "$path_games/Test Drive Unlimited 2" ]; then

	WINEPREFIX=\""$tdu2Prefix"\" WINEARCH=win32 winetricks -q dotnet40 dxvk1103 ie7 dinput8 directplay 

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh
	
	echo -n WINEPREFIX=\""$tdu2Prefix"\" WINEARCH=win32 wine "$(ls *.exe)" >> start.sh 

	fi

	cd ..;

	done

	zenity --info --text="Script generation complete"

	ZenityUI
}

sr2Parser()
{
	for folder in "$path_games"/*; do cd "$folder";

	if [ "$(pwd)" == "$path_games/Saints Row 2" ]; then

	WINEPREFIX=\""$sr2Prefix"\" winetricks xact

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh

	echo -n WINEPREFIX=\""$sr2Prefix"\" wine "$(ls *.exe)" >> start.sh

	fi

	cd ..;

	done

	zenity --info --text="Script generation complete"

	ZenityUI
}

blurParser()
{
	for folder in "$path_games"/*; do cd "$folder";

	if [ "$(pwd)" == "$path_games/Blur" ]; then

	WINEPREFIX=\""$blurPrefix"\" winetricks -q vcrun2019 dxvk1030

	echo "#!/bin/bash" > start.sh

	echo -e >> start.sh

	echo -e cd \"$(pwd)\" >> start.sh

	echo -e >> start.sh
		
	echo -n WINEPREFIX=\""$blurPrefix"\" >> start.sh

	fi

	cd ..;

	done

	zenity --info --text="Script generation complete"

	ZenityUI
}

ZenityUI()
{
	parser_ID=$(zenity --list --text="Select a Parser" --column="ID" --column="Name" --column="Description" --width=800 --height=600 \
	1 Citra   	   "Nintendo 3DS Emulator" \
	2 melonDS 	   "Nintendo DS Emulator" \
	3 mGBA    	   "Gameboy Advance Emulator" \
	4 Xemu    	   "Original Xbox Emulator" \
	5 Xenia   	   "Xbox 360 Emulator" \
	6 Ppsspp  	   "PSP Emulator" \
	7 Pcsx2   	   "PS2 Emulator" \
	8 Duckstation  "PS1 Emulator" \
	9 Yuzu/Ryujinx "Nintendo Switch Emulator" \
	10 Wine 	   "Windows .exe games (default prefix)" \
    11 Blur   	   "custom prefix" \
	12 "Saints Row 2" "custom prefix" \
	13 "Test Drive Unlimited 2" "custom prefix")

	# If user presses "cancel" on main window then quit program
	if [ $? == 1 ]; then exit

	fi

	zenity --info --text="Select the ROM's directory"

	path_games=$(zenity --title="Select ROM's path" --directory --file-selection)

	if [ $? == 1 ]; then ZenityUI

	fi

	#Check if have to use default wine prefix or a specific prefix, or just select emulators.
	if [ $parser_ID == 10 ]; then 

	zenity --info --text="Using default wine prefix, initializing with wineboot."

	wineboot

	zenity --info --text="installing vcrun2019, dxvk and vkd3d in default prefix"

	winetricks -q vcrun2019 dxvk vkd3d

	elif [ $parser_ID == 11 ]; then

	zenity --info --text="Select the prefix folder to use for Blur"
	blurPrefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
	if [ $? == 1 ]; then ZenityUI
	fi

	elif [ $parser_ID == 12 ]; then

	zenity --info --text="Select the prefix folder to use for Saints Row 2"
	sr2Prefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
	if [ $? == 1 ]; then ZenityUI
	fi

	elif [ $parser_ID == 13 ]; then

	zenity --info --text="Select the prefix folder to use for Test Drive Unlimited 2"
	tdu2Prefix=$(zenity --title="Select Prefix Folder" --directory --file-selection)
	if [ $? == 1 ]; then ZenityUI
	fi

	# We use xenia canary windows build for now, which requires wine.
	elif [ $parser_ID == 5 ]; then

	zenity --info --text="Using default wine prefix, initializing with wineboot."

	wineboot

	zenity --info --text="installing vcrun2019, dxvk and vkd3d in default prefix"

	winetricks -q vcrun2019 dxvk vkd3d

	zenity --info --text="Select the Emulator Executable"

	path_executable=$(zenity --title="Emulator Selection" --file-selection)

	# Other emulators don't require wine, since using native linux builds.
	else zenity --info --text="Select the Emulator Executable"
	
	path_executable=$(zenity --title="Emulator Selection" --file-selection)

	if [ $? == 1 ]; then ZenityUI
	fi 

	fi
}

# Detect available UI selection interfaces. type returns 0 if command is available, 1 if not.

type zenity >> /dev/null
zenityPresent=$?

type wine >> /dev/null
winePresent=$?

type winetricks >> /dev/null
winetricksPresent=$?

# Check if needed components are available

if [ $winePresent != 0 ]; then 

zenity --error --text="Wine must be installed in your system"
exit

elif [ $winetricksPresent != 0 ]; then 

zenity --error --text="Winetricks must be installed in your system"
exit

elif [ $zenityPresent == 0 ]; then ZenityUI

else echo "Zenity must be installed in your system to display UI."; exit;

fi


case $parser_ID in

	1) 
	citraParse
	;;
	
	2)
	melonDSParse
	;;
	
	3)
	mGBAParse
	;;
	
	4)
	XemuParse
	;;
	
	5)
	XeniaParse
	;;
	
	6)
	PpssppParse
	;;
	
	7)
	Pcsx2Parse
	;;
	
	8)
	DuckstationParse
	;;
	
	9)
	YuzuRyujinxParse
	;;
	
	10)
	WineParseGeneric
	;;
	
	11)
	blurParser
	;;

	12)
	sr2Parser
	;;
	
	13)
	tdu2Parser
	;;
	
	*)
	
	echo -n "Invalid option"
	;;
   esac
