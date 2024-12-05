#!/usr/bin/env bash

case "$1" in
	"")
		sum=0
		input=""

		while read -r line; do input+="${line}"$'\n'; done

		((sum+=$("$0" hor XMAS <<< "$input")))       # L→R
		((sum+=$("$0" hor SAMX <<< "$input")))       # R→L

		((sum+=$("$0" ver <<< "$input")))

		((sum+=$("$0" dia <<< "$input")))
		((sum+=$(rev <<< "$input" | "$0" dia)))

		echo $sum
		;;
	hor)
		sum=0
		while read line; do ((sum+=$(grep -o "$2"<<< $line|wc -l))) done
		echo $sum
		;;
	ver)
		input=()
		while read line; do input+=("$line"); done
		
		sum=0
		for x in $(seq 1 ${#input[0]}); do
			sub=""
			for line in ${input[@]}; do
				sub+=${line:$((x-1)):1}
			done
			((sum+=$(grep -o XMAS<<<$sub|wc -l)))
			((sum+=$(grep -o SAMX<<<$sub|wc -l)))
		done
		echo $sum
		;;
	dia)
		input=()
		while read line; do input+=($line); done

		for x in ${!input[@]}; do
			printf "%0.s-" $(seq 0 $x)
			printf "%s" "${input[$x]}"
			printf "%0.s-" $(seq 1 $((${#input[@]}-x)))
			printf "\n"
		done | "$0" ver
		;;
esac

