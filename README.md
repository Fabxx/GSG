# LinuxGSG
GSG Is a game script  generator. Allows you to automatically create sh files to run games.

The purpose is to allow users to run games just with Wine and winetricks packages, no proton, lutris or whatever in a straightfoward way, and also generate
scripts that will allow users to launch games on emulators immediatly with the needed arguments.

this does NOT configure automatically the emulators, you have to do that on your own.

# Adding game setups for PC games

If a game setup that you know is missing in the `game setups.txt` file inside PC folder, please create an issue with the appropriate labels.


# Currently Supported extension detection:
```
PC (.exe)

PCSX2 (.iso)

mGBA (.gbc | .gba | .gb)

Xemu (.iso)

Xenia (.xex | .iso | .zar)

MelonDS (.nds | .dsi | .ids | .app)

PPSSPP (.iso)

Duckstation (.bin | .iso | .img)  

Yuzu/Ryujinx (.xci | .nsp)
```

# How to use

All you have to do is configure the paths indicated in the scripts folder, the script will take care of the rest.

You can tweak the scripts how you want to add/remove variables, for example to add more prefixes, more paths, DLL overrides ecc.

This will generate a `start.sh` in each game folder to allow you to run the games with a single execution instead of manually
searching for the file, write the commands and run it.
