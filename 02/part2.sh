#!/usr/bin/env bash

case "$1" in
	"")
		sum=0

		while read -a nums; do
			
			if [[ $("$0" check ${nums[@]}) == 0 ]]; then
				for i in ${!nums[@]}; do
					slice=()
					for j in ${!nums[@]}; do
						if [[ $i == $j ]]; then
							continue
						fi
						slice+=(${nums[$j]})
					done

					if [[ $("$0" check ${slice[@]}) != 0 ]]; then
						((sum+=1))
						break
					fi
				done
			else
				((sum+=1))
			fi
		done

		echo $sum
		;;
	check)
		nums=(${@:2})
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

		echo $safe
		;;
esac

