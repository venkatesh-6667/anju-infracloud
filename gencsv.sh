#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_index> <end_index>"
    exit 1
fi

start_index=$1
end_index=$2

if [ $start_index -ge $end_index ]; then
    echo "Error: Start index must be less than end index."
    exit 1
fi

filename="inputdata"

echo "Generating $filename..."

# Remove inputFile if it exists
if [ -e "inputdata" ]; then
    rm inputdata
fi

for ((i=start_index; i<=end_index; i++)); do
    rand_num=$((1 + $RANDOM ))
    echo "$i,$rand_num" >> "$filename"
done

echo "File $filename generated successfully."
