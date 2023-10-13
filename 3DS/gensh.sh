#!/bin/bash

# Define your path that contains the games. Each game must have it's own folder. DO NOT PUT / AT THE END OF THE STRING, because that's in the for for the recursive search.
path_games="/path/to/3DS/roms"

path_executable="/path/to/Citra/executable"


# Generate shell files

for folder in "$path_games"/*; do cd "$folder";

echo $(pwd); #show if goes into the folders successfully.

echo -e cd \"$(pwd)\" > start.sh

echo -e >> start.sh

# Don't worry if in some folders it says "file not found", because it tires to parse all extensions in each folder. So a single match is guaranteed

echo -n \""$path_executable"\" "" \""$(ls *.{cia, 3ds})"\" >> start.sh

cd ..;

done;

