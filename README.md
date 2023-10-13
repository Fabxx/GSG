# LinuxGSG
GSG Is a game script  generator. Allows you to automatically create sh files to run games.

The purpose is to allow users to run games just with Wine and winetricks packages, no proton, lutris or whatever.

# Adding game setups for PC games

If a game setup that you know is missing in the `game setups.txt` file inside PC folder, please create an issue with the appropriate labels.


# Currently Supported Platforms:

PC games

# Planned support to generate scripts with:

PCSX2

PPSSPP

Yuzu/Ryujinx

Duckstation

mGBA

Xemu

Xenia


# What it does (PC)

-Allows you to configure the script with a text editor

-Allows you to choose a dedicated prefix or default wine prefix

-Allows to automatically apply the WINEDLLOVERRIDES, WINEARCH and wine commmand arguments if you specify it.

-Recursively scans the game folders to find the exe to run and creates the script with the commands in it.

# What it does (Emulators)

-Generates a runner with the emulator executable, with arguments and paths to game files.
