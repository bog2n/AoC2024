#!/usr/bin/env bash

declare -i left
declare -i right

while read -r line; do
	left+=($(cut -d' ' -f1 <<< "$line"))
	right+=($(cut -d' ' -f4 <<< "$line"))
done

left=($(tr ' ' '\n'<<<"${left[@]}"|sort -n))
right=($(tr ' ' '\n'<<<"${right[@]}"|sort -n))

sum=0

for (( i=0; i<${#left[@]}; i++ )); do
	dist=$((left[i]-right[i]))
	((sum+=${dist#-}))
done

echo $sum

