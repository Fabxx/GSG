#!/bin/bash

# Define your path that contains the games. Each game must have it's own folder. DO NOT PUT / AT THE END OF THE STRING, because that's in the for for the recursive search.
path_games="/path/to/DS/games"

path_executable="/path/to/melonDS/bin"


# Generate shell files

for folder in "$path_games"/*; do cd "$folder";

echo $(pwd); #show if goes into the folders successfully.

echo -e cd \"$(pwd)\" > start.sh

echo -e >> start.sh

echo -n \""$path_executable"\" "" \""$(ls *.{nds,dsi,ids,app})"\" >> start.sh

cd ..;

done;


