#!/usr/bin/env bash

declare -A blocks
guard=()
y=0
width=0
height=0

while read line; do
	width=${#line}
	for (( x=0; x<${#line}; x++ )); do
		case ${line:$x:1} in
			'#') blocks[$x,$y]=1 ;;
			'^') guard=($x $y) ;;
		esac
	done
	((y+=1))
done
height=$y

dir=(0 -1)
declare -A visited

while [[ ${guard[0]} -ge 0 ]] && [[ ${guard[0]} -lt $width ]] &&
      [[ ${guard[1]} -ge 0 ]] && [[ ${guard[1]} -lt $height ]]; do

	visited[${guard[0]},${guard[1]}]=1

	peekx=$((guard[0]+dir[0]))
	peeky=$((guard[1]+dir[1]))
	if [[ ${blocks[$peekx,$peeky]} == 1 ]]; then
		dir=($((dir[1]*-1)) ${dir[0]})
	fi

	((guard[0]+=dir[0]))
	((guard[1]+=dir[1]))
done

echo ${#visited[@]}

