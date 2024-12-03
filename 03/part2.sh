#!/usr/bin/env bash

input=""
while read line; do
	input+="$line"
done

echo $(($(printf '(';sed -E "s/mul\(([0-9]{1,3})\,([0-9]{1,3})\)/\n\1*\2+\n/g;\
	s/do\(\)/\n0)+1*(\n/g;s/don't\(\)/\n0)+0*(\n/g"<<<$input|\
	sed -nE "/([0-9]{1,3}\*[0-9]{1,3}\+)|([01]\*)/p"|tr -d '\n';printf '0)')))

