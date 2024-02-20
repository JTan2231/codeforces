#!/bin/bash

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 folder_name subfolder1 [subfolder2 ...]"
    exit 1
fi

folder_name="$1"
shift # Remove the first argument, so $@ contains only subfolders

# Iterate over the rest of the arguments, which are subfolder names
for subfolder in "$@"; do
    # Create the subfolder path
    mkdir -p "${folder_name}/${subfolder}"

    cp main.cpp "${folder_name}/${subfolder}"
    
    # Navigate to the subfolder
    pushd "${folder_name}/${subfolder}" >/dev/null
    
    # Create and populate the 'i' and 'b' files
    echo "xsel -b >> i.txt" > i
    echo "g++ main.cpp -o test && cat i.txt | ./test" > b

    # Make 'i' and 'b' executable
    chmod +x i b

    # Move 'i' and 'b' to the subfolder (already there, so this step is not needed)

    # Navigate back to the original directory
    popd >/dev/null
done
