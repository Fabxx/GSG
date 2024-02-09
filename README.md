# GSG
GSG Is a game script generator that generates `sh`/`lnk` runners per game.

# Key Features

- Multiple emulator extension parse

- Auto sort roms into folders (Linux only for now)

- Automatic prefix creation and setup (Linux Only, for wine)

- Automatic application of arguments, overrides and such.

# Contributing

- If a game setup is missing in the `game setups.txt`, please create an issue with the appropriate labels.
  I will add the wine configuration and if available, the necessary DLL overrides in the script for the missing game.

- If in the script there is a missing game that contains the main .exe in a subfolder, please report it and i will add it to the
  local comparison in the script.
  
- If emulator arguments are missing, please report them with a github issue, or contribute by adding them.


# Currently Supported extension detection:

note: emulator names are only for console references, if you have these file extensions it will be supported anyways.

```
PC (.exe)

PCSX2 (.iso | .chd)

mGBA (.gbc | .gba | .gb)

Xemu (.iso)

Xenia (.xex | .iso | .zar)

Cxbx-Reloaded (.xbe)

MelonDS (.nds | .dsi | .ids | .app)

Citra (.cia | .3ds)

PPSSPP (.iso)

Duckstation (.cue | .iso | .img | .ecm | .chd)  

Yuzu/Ryujinx (.xci | .nsp)

Cemu (.wum | .wux)

Mupen64 (.z64 | .v64 | .n64)

Snes9x (.smc | .sfc)

Dolphin (.wbfs | .wad | .iso | .gcz | .rvz | .dol | .elf)

Rpcs3 (EBOOT.BIN)
```
# Depencies (Linux)

- For PC Parser: `winetricks` | `wine` 

- Main Depency: `Zenity` for UI.

  Debian/Ubuntu  `sudo apt install zenity wine winetricks`

  Arch 	   	 `sudo pacman -S zenity wine winetricks`

# Initial Setup for Linux

- (PC games only) First of all, setup your games by following the `Game Setups.txt` document.

- (PC Games only) if multiple `.exe` are on the same directory, rename the extension of the unnecessary executables, then run the parser.

- Extra prefixes for specific games must be created in disks with `EXT` filesystem, or else the program won't allow you to use that folder as a wine prefix.

- If you need to auto sort, put all files and covers in the same folder. The files must have the same names. (showcase below)

# How to use (shell file)

- Give execution permission: `chmod +x generator.sh`

- Run the script: `./generator.sh >/dev/null 2>&1` (if you want terminal logging, remove the `>/dev/null 2>&1`)

- Choose the parser you need

- Setup the paths when asked to do so

- The program can sort the rom files and cover images into folders for you if you haven't. More info in the option 5 of the Menu.

- If using wine parser and have specific games that require a dedicated setup, check that the comparison strings for the names in the wine parser
  match your game folder names. If not, you can either rename your folders, or rename the strings in the comparisons.

# How to use (Powershell file)

Simply open powershell prompt and execute with `.\generator.ps1`, a CLI interface has been provided to 
select the parsers

# Integrating with steam rom manager

parser setup:

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

Detects all start.sh files, along with jpg covers (change the extension if you use another format)

You can duplicate this parser and change the category, title name and ROM's path since now everything uses a `sh` file as a base to run the games, emulators ecc,

You won't have to make specific configurations for each executable, the arguments are also included in the generated sh files.


# Special Thanks

SSUPII - Bug Fixes, testing and suggestions. https://github.com/SSUPII

# Wine parser showcase

https://github.com/Fabxx/LinuxGSG/assets/30447649/dd7a43d9-ba87-416d-b4fe-de14ffc36728

# Emulator parser showcase (autoSort)

https://github.com/Fabxx/LinuxGSG/assets/30447649/0bf8c882-6297-46b4-a93e-41b17c0ae639


# Steam Rom Manager Integration showcase

https://github.com/Fabxx/LinuxGSG/assets/30447649/47bbbafa-69f7-4d5d-a70c-1f0a95b97a13


# Powershell script showcase (todo)

