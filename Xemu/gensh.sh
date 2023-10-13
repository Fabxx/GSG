#!/bin/bash

# Define your path that contains the games. Each game must have it's own folder. DO NOT PUT / AT THE END OF THE STRING, because that's in the for for the recursive search.
path_games="/path/to/xbox/games"

path_executable="/path/to/xemu/Bin"

# Define game arguments

args="-dvd_path"

# Generate shell files

for folder in "$path_games"/*; do cd "$folder";

echo $(pwd); #show if goes into the folders successfully.

echo -e cd \"$(pwd)\" > avvia.sh

echo -e >> avvia.sh

echo -n \""$path_executable"\" "" "$args" "" \""$(ls *.iso)"\" >> avvia.sh

cd ..;

done;


