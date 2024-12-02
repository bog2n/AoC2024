#!/usr/bin/env bash

sum=0

while read -a nums; do
	safe=1
	sign=$((nums[1]-nums[0]))

	for i in $(seq 2 ${#nums[@]}); do
		int=$((nums[i-1]-nums[i-2]))

		if [[ $((int*sign)) -le 0 ]]; then
			safe=0
		fi

		if [[ ${int#-} -gt 3 || ${int#-} == 0 ]]; then
			safe=0
		fi
	done

	((sum+=safe))
done

echo $sum

