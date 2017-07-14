#!/bin/sh
echo "Called: $*"
I=0
J=`grep -m1 -ao '[0-9]' /dev/urandom | sed s/0/10/ | head -n1`
# J=4
while true
do
	sleep 1
	I=$((I+1))
	echo "$3: $I/$J"
	if [ "$I" -eq "$J" ]
	then
		break
	fi
done
