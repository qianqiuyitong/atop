#!/bin/bash
LOGPATH=/var/log/atop
LOGGENERATIONS=5
ATOPRC="/etc/atoprc"
if [ -f $ATOPRC ]; then
	RCGENERATIONS=`cat $ATOPRC | grep generations -m 1 | awk '{print $2}'`
	if [ -n "$RCGENERATIONS" ]; then
		LOGGENERATIONS=$RCGENERATIONS
	fi
fi

# delete logfiles older than N days (configurable)
# start a child shell that activates another child shell in
# the background to avoid a zombie
#
find "$LOGPATH" -name 'atop_*' -mtime +"$LOGGENERATIONS" -exec rm {} \;
