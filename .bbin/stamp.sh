#!/bin/sh

([ ! $1 ] || [ $2 ]) && exit

DATE=`date +%s`
OUT=`echo $1 | sed s/\\\\.[A-Za-z0-9_]*$/_$DATE\&/`
if [ $OUT = $1 ] ; then OUT=$1_$DATE ; fi

echo $OUT
