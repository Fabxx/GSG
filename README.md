# LinuxGSG
GSG Is a game script  generator. Allows you to automatically create sh files to run games.

The purpose is to allow users to run games just with Wine and winetricks packages, no proton, lutris or whatever.

# Adding game setups

If a game setup that you know is missing in the `game setups.txt` file, please create an issue with the appropriate labels.

# PC games Specifications
In this script are also documented the `WINEDLLOVERRIDES` and game arguments that i found over time.

winetricks packages are documented in the `game setups.txt` document.

I've also included a game setup document that indicates for each tested game what packages are required and how to setup the games to work.

# Currently Supported Platforms:

PC games

# Planned support to generate scripts with:

PCSX2

PPSSPP

Yuzu/Ryujinx

Duckstation

mGBA



# What it does (PC)

-Allows you to configure the script with a text editor

-Allows you to choose a dedicated prefix or default wine prefix

-Allows to automatically apply the WINEDLLOVERRIDES, WINEARCH and wine commmand arguments if you specify it.

-Recursively scans the game folders to find the exe to run and creates the script with the commands in it.

# Initial Setup (PC)

First of all there's a thing to take care about. The script scans recursively for `.exe` extension file name,
so if you have other exes in the same directory of the game executable, rename the other ".exe" into ".EXE" or
just remove the extension.

# Creating the Prefix
The disk MUST be in `EXT4` filesystem format. create a new folder where you want inside that disk.
then initialize it with `WINEPREFIX="/path/to/prefix" wineboot`

# Usage of the script

once you defined your paths inside the script (everything is documented and explained in it how to do it) simply run it with

`./gen.sh`


# Integrating with steam rom manager (PC)

We can run these generated scripts from steam with steam rom manager. To do so you have to create a parser with these settings:

Parser type: glob

Config title: PC

Steam directory: usually /home/user/.steam/root

User Accounts: ${Steam Username}

Steam category: PC

ROMs directory: /path/to/your/games

Executable: /usr/bin/bash

command line arguments: "${filePath}"

User's glob: ${title}/start.sh

For portaits itis recommended to use a 500x700 image with an extension you want, each cover must be put in the main game folder, not in subfolders.

Local portraits image: /path/to/games/${title}/*@(.jpg)


Run the parses and it will detect all the "start.sh" created for each game folder, and it will associate the covers we made.
