#!/bin/sh
# Print BIND's qps periodically

if [ $# -lt "2" ] ; then
    echo "Usage:"
    echo "    rndc_qps.sh [statistic_file] [interval]"
    exit 0;
fi

tic=0
statsfile=$1
interval=$2
first=0
while true
do
    rndc stats
    tick=`egrep QUERY $statsfile | tail -1 | awk '{print $1}'`
    diff=`expr $tick - $tic`
    qps=`expr $diff / $interval`

    if [ $first -ne "0" ]; then
        echo "$qps requests/second"
    else
        first=1
    fi

    sleep $interval
    tic=$tick
done
