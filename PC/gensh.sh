#!/bin/bash

# Put here your prefix path, if you have more, just define a new variable and change the path. if you want to use you default .wine prefix (not recommended)

# don't use any of the defined variables, but it is recommended to separate your prefixes in case of game-specific requirements.

prefix="/path/to/prefix"

# Define your path that contains the games. Each game must have it's own folder. * is for recursive search.

path_games="/path/to/games/*"

# Define DLL Overrides if needed.

# Here i leave the  DLL overrides for some games, the list will be updated when new overrides will be needed for other games

# Current games that use the overrides: need for speed most wanted/carbon - splinter cell 1/Pandora tomorrow/Chaos Theory - Dirt/2/3/Showdown

NFSC_MW_OVERRIDE="*d3d9,*d3d10,*d3d10_1,*d3d10core,*d3d11,*dxgi=b"

SC_SCPT_OVERRIDE="*d3d8, *msacm32, *msvfw32=n,b"

SCCT_OVERRIDE="*d3d9, *msacm32, *msvfw32=n,b"

DIRT_2_3_SH_OVERRIDE="*openal32=n,b"

# Define game arguments, same as above i'll leave them here when discovered. Can be useful to launch games with specific arguments.

# Current Arguments: Colin McRae Rally 2005 - Kingdom Come Deliverance - Splinter Cell Chaos Theory

CMR2005="FORCEHT WIDESCREENDISPLAY NOVIDEO"

KINGDOMDEV="-devmode"

SCCT_SKIP_VIDEO="-nointro"


# Generate shell files, first go into the main game dir, then add  WINEPREFIX command with path, specify WINEARCH (if needed), add overrides and append data.

for folder in $path_games; do cd "$folder";

echo $(pwd); #show if goes into the folders successfully.

echo -e cd \"$(pwd)\" > start.sh

echo -e >> avvia.sh

# Detect if you reached the game that requires overrides, a different prefix or a specified WINEARCH, if not fallback to the default command.
# Here are some examples between the simple command and the modified command.
# NOTE: with $PWD you need to copy paste the ABSOLUTE path for comparison.

# if you need more comparisons just add another elif instruction after the last elif. Last instruction will always be the else and then fi.

# you can edit and duplicate these commands with the path you need and the commands you need to add.

# this string specifies the WINEARCH since the prefix required for this game is 32 bit.
if   [ "$(pwd)" == "/media/user/disk/Games/Test Drive Unlimited 2" ]; then echo -n WINEPREFIX=\""$prefix_tdu2"\" \ WINEARCH=win32 >> start.sh
 
#in this case we specify the DLL OVERRIDES, just delete the string after the $ inside the quotes and replace it with yours.

elif [ "$(pwd)" == "/media/user/disk/Games/Tom Clancys Splinter Cell" ]; then echo -n WINEPREFIX=\""$prefix_scct"\" WINEDLLOVERRIDES=\""$SC_SCPT_OVERRIDE"\" >> start.sh 

# Note that you can combine the command specifications if you need. so you can use WINEARCH and WINEDLLOVERRIDES in the same string.

# Default string, just wineprefix without overrides.

else echo -n WINEPREFIX=\""$prefix"\" >> start.sh

fi


# If a game has the main .exe in a subfolder, give the extra path to wine command, then if available pass arguments
# you have to give manually the path here from the file manager, like the paths above for comparison.

#if the main exe to use is among other exes, rename the extension of those from ".exe" into ".EXE" or ".e" since this parser detects only .exe.

# Example of adding arguments with cmr 2005

if [ "$(pwd)" == "/media/user/disk/Colin McRae Rally 2005" ]; then echo -n "" wine "$(ls *.exe)" "$CMR2005" >> start.sh

# example of subfolder path for the exe.
elif [ "$(pwd)" == "/media/user/disk/Borderlands" ]; then echo -n "" wine "$(ls Binaries/*.exe)" >> start.sh

# if the exe isn't in subdirs fallback to default string.

else echo "" wine "$(ls *.exe)" >> start.sh 

fi

cd .. 

done;


