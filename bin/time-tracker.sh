#!/bin/bash

# call without argument to get time on current task.
# call with argument TASKNAME to set current task.

LOGFILE="$HOME/.time-tracker.log"

if [[ $1 == '' ]]; then
    taskstart=$(cat $LOGFILE | cut -c -30 | tail -n 1)
    echo $taskstart
    timesince=$(date -u -d@$(($(date +%s) - $(date --date="$taskstart" +%s))) +%H:%M)
    taskname=$(cat $LOGFILE | cut -c 32- | tail -n 1)
    echo $taskname $timesince
else
    echo $(date) $1 >> $LOGFILE
fi

