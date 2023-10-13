# Xemu
This script parses `.iso` files to use with Xemu.

# Initial setup

configure the emulator following the official xemu guide:

https://xemu.app/docs/required-files/


# Usage

Just define the paths in the variables, the scripts will take care of the rest.

`./gen.sh`


# Integrating with steam rom manager

Since we're always using sh file formats, you can replicate the parser of the PC section in the rom manager.

Just rename the category with the name of the emu/console
