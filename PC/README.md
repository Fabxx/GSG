# PC

In this script are also documented the `WINEDLLOVERRIDES` and the `winetricks` packages to use for a specific case.

I've also included a game setup document that indicates for each tested game what packages are required and how to setup the games to work.


# Initial Setup

First of all there's a thing to take care about. The script scans recursively for `.exe` extension file name,
so if you have other exes in the same directory of the game executable, rename the other ".exe" into ".EXE" or
just remove the extension.

# Creating the Prefix
The disk MUST be in `EXT4` filesystem format. create a new folder where you want inside that disk.
then initialize it with `WINEPREFIX="/path/to/prefix" wineboot`

# Usage

once you defined your paths inside the script (everything is documented and explained in it how to do it) simply run it with

`./gen.sh`
