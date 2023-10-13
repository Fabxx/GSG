# LinuxGSG
GSG Is a game script  generator. Allows you to automatically create sh files to run games.

The purpose is to allow users to run games just with Wine and winetricks packages, no proton, lutris or whatever in a straightfoward way, and also generate
scripts that will allow users to launch games on emulators immediatly with the needed arguments.

this does NOT configure automatically the emulators, you have to do that on your own.

# Adding game setups for PC games

If a game setup that you know is missing in the `game setups.txt` file inside PC folder, please create an issue with the appropriate labels.

I will add the wine configuration and if available, the necessary DLL overrides in the script for the missing game.


# Currently Supported extension detection:
```
PC (.exe)

PCSX2 (.iso)

mGBA (.gbc | .gba | .gb)

Xemu (.iso)

Xenia (.xex | .iso | .zar)

MelonDS (.nds | .dsi | .ids | .app)

Citra (.cia | .3ds)

PPSSPP (.iso)

Duckstation (.bin | .iso | .img)  

Yuzu/Ryujinx (.xci | .nsp)
```

# How to use

All you have to do is configure the paths indicated in the scripts folder, the script will take care of the rest.

You can tweak the scripts how you want to add/remove variables, for example to add more prefixes, more paths, DLL overrides ecc.

This will generate a `start.sh` in each game folder to allow you to run the games with a single execution instead of manually
searching for the file, write the commands and run it.

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

command line arguments: "${filePath}"

User's glob: ${title}/start.sh

For portaits it is recommended to use a 500x700 image with an extension you want, each cover must be put in the main game folder
not in subfolders.

Local portraits image: /path/to/games/${title}/*@(.jpg)
```


Run the parses and it will detect all the "start.sh" created for each game folder, and it will associate the covers we made.

You can duplicate this parser and change the category and title name, since now everything uses a `sh` file as a base to run the games, emulators ecc,

You won't have to make specific configurations for each executable, the arguments are also included in the generated sh files.
