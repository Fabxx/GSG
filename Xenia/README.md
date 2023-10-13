# Xenia
This script parses `.xex, .iso` files to use with Xenia, so you can also use decompressed isos to save some space.

# Initial setup

get xenia canary form here:

https://github.com/xenia-canary/xenia-canary

Configure your wine prefix with dxvk and vkd3d. We're gonna run the windows build since the Linux support is a Work in Progress.

If you plan to play on vulkan renderer, which is not recommended yet btw, you don't need to put dxvk and vkd3d in the prefix.

# Usage

Just define the paths in the variables, the scripts will take care of the rest.

`./gen.sh`


# Integrating with steam rom manager

Since we're always using sh file formats, you can replicate the parser of the PC section in the rom manager.

Just rename the category with the name of the emu/console
