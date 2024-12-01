#!/usr/bin/env bash

declare -a left
declare -a right

sum=0

while read -r line; do
	l=$(cut -d' ' -f1 <<< "$line")
	r=$(cut -d' ' -f4 <<< "$line")
	((left[l]+=1))
	((right[r]+=r))
done

for l in ${!left[@]}; do
	((sum+=left[l]*right[l]))
done

echo $sum

