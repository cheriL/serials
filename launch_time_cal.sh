#!/bin/bash

set -e
#set -x

LOG_FILE=k1.log
SUM=0

replicas=$(cat $LOG_FILE | grep "duration" | wc -l)
# [ $replicas != $1 ] && exit 1
echo "replicas: $replicas"

declare launch_results
readarray -n 0 launch_results < <(cat $LOG_FILE | grep "duration" | awk '{print $10}')

for result in "${launch_results[@]}"; do
    num=$(echo "${result}" | cut -d '=' -f  2 | cut -d 's' -f 1 | cut -d 'm' -f 1)
    SUM=$(echo "$SUM + $num" | bc)
done

echo "sum launch time: $SUM"
avg=$(echo "$SUM/$replicas" | bc -l)
printf $avg