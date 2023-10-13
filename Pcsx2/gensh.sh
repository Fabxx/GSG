#!/bin/bash

# Define your path that contains the games. Each game must have it's own folder. DO NOT PUT / AT THE END OF THE STRING, because that's in the for for the recursive search.
path_games="/path/to/PS2/games"

# Set the path where your PCSX2 exetuable is.
path_executable="/path/to/pcsx2/bin"

# Define game arguments

args="-fullscreen"

# Generate shell files

for folder in "$path_games"/*; do cd "$folder";

echo $(pwd); #show if goes into the folders successfully.

echo -e cd \"$(pwd)\" > start.sh

echo -e >> start.sh

echo -n \""$path_executable"\" "" \""$(ls *.iso)"\" "" "$args" >> start.sh


cd ..;

done;


