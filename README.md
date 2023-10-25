# LinuxGSG
GSG Is a game script  generator. Allows you to automatically create sh files to run games.

The purpose is to allow users to run games and emulators through automatically generated runners, with arguments and command lines integrated in the 
generation, without the need of extra software and thinkering.

this does NOT configure automatically the emulators, you have to do that on your own.

# Contributing

If a game setup that you know is missing in the `game setups.txt` file inside `PC` folder, please create an issue with the appropriate labels.
I will add the wine configuration and if available, the necessary DLL overrides in the script for the missing game.

if in the script there is a missing game that contains the main .exe in a subfolder, please report it and i will add it to the
local comparison in the script.


# Currently Supported extension detection:
```
PC (.exe)

PCSX2 (.iso)

mGBA (.gbc | .gba | .gb)

Xemu (.iso)

Xenia (.xex | .iso)

Cxbx-Reloaded (.xbe)

MelonDS (.nds | .dsi | .ids | .app)

Citra (.cia | .3ds)

PPSSPP (.iso)

Duckstation (.cue | .iso | .img | .ecm)  

Yuzu/Ryujinx (.xci | .nsp)

Cemu (.wum | .wux)

Mupen64 (.z64 | .v64 | *.n64)

Snes9x (.smc | .sfc)

Dolphin (.wbfs | .wad | .iso | .gcz | .rvz | .dol | .elf)

Rpcs3 (EBOOT.BIN | .iso)
```
# Depencies
For PC Parser: `winetricks` | `wine` 

Main Depency: `Zenity` for UI.

# Initial Setup
- (PC games only) First of all, setup your games by following the Game Setups txt document. If a game is not available please report it
  and if possible, add documentation about what it needs to run in wine via github issues.

- Games must be in their individual folders, regrouped in a subfolder.

- if there are more files with the same extension in the same directory, rename the extension of the unnecessary files based on the parser to use, then run the parser.
  so for example if you have to parse for .exe, rename all the other exes that you don't need into .EXE, or just remove the extension.

- Extra prefixes for specific games MUST be created in disks  with `EXT` filesystem, or else the program won't allow you to use that folder as a wine prefix.

# How to use

I provided a UI with Zenity, all you have to do is configure the requested paths.

This will generate a `start.sh` in each game folder to allow you to run the games with a single execution instead of manually
searching for the file, write the commands and run it, it also applies arguments if known.

You can tweak the wine parser to add more specific game cases for the script generation (or suggest some that i will add in updates).
only the WINE parser can need tweaks based on your game folder names with the comparisons.

# Integrating with steam rom manager

We can run these generated scripts from steam with steam rom manager. To do so you have to create a parser with these settings:

```
Parser type: glob

Config title: put name here

Steam directory: usually /home/user/.steam/root

User Accounts: ${Steam Username}

Steam category: Category name

ROMs directory: /path/to/your/games

Executable: /usr/bin/bash

command line arguments: "${filePath}" (write this as it is!)

User's glob: ${title}/start.sh (write this as it is!)

For portaits it is recommended to use a 500x700 image with an extension you want, each cover must be put in the main game folder
not in subfolders.

Local portraits image: /path/to/games/${title}/*@(.jpg)
```

Run the parser and it will detect all the "start.sh" created for each game folder in the specified path, and it will associate the covers we made.

You can duplicate this parser and change the category, title name and ROM's path since now everything uses a `sh` file as a base to run the games, emulators ecc,

You won't have to make specific configurations for each executable, the arguments are also included in the generated sh files.


# Special Thanks

SSUPII - Bug Fixes and testing https://github.com/SSUPII

# Wine parser showcase

https://github.com/Fabxx/LinuxGSG/assets/30447649/dd7a43d9-ba87-416d-b4fe-de14ffc36728

# Emulator parser showcase

https://github.com/Fabxx/LinuxGSG/assets/30447649/eebbe82e-6bbd-4179-9a5f-26593f45bb1d

# Steam Rom Manager Integration showcase

https://github.com/Fabxx/LinuxGSG/assets/30447649/47bbbafa-69f7-4d5d-a70c-1f0a95b97a13


