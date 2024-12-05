#!/usr/bin/env bash

width=0
height=0
input=()
sum=0

while read line; do
	width=${#line}
	((height+=1))
	input+=("$line")
done

for (( y=1; y<$height-1; y++)); do
	for (( x=1; x<$width-1; x++ )); do
		line=${input[$y]}
		if [[ ${line:$x:1} == A ]]; then
			top=${input[$((y-1))]}
			bottom=${input[$((y+1))]}

			if (
			    ([[ ${top:$((x-1)):1} == M ]] &&
			    [[ ${bottom:$((x+1)):1} == S ]]) ||
			    ([[ ${top:$((x-1)):1} == S ]] &&
			    [[ ${bottom:$((x+1)):1} == M ]])
			   ) && (
			    ([[ ${bottom:$((x-1)):1} == M ]] &&
			    [[ ${top:$((x+1)):1} == S ]]) ||
			    ([[ ${bottom:$((x-1)):1} == S ]] &&
			    [[ ${top:$((x+1)):1} == M ]])
			); then ((sum+=1)); fi
		fi
	done
done

echo $sum
