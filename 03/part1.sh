#!/usr/bin/env bash

sum=0

while read line; do
	((sum+=$(sed -E "s/mul\(([0-9]{1,3})\,([0-9]{1,3})\)/\n\1*\2+\n/g"<<<$line|\
		sed -nE "/[0-9]{1,3}\*[0-9]{1,3}\+/p"|tr -d '\n';printf 0)))
done

echo $sum

