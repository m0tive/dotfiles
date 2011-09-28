#!/bin/sh

EDITOR=vim
TMPFILE=$TEMP/$$-$1

echo get "$1" -o "$TMPFILE"
echo shell $EDITOR "$TMPFILE"
echo put -E "$TMPFILE" -o $1
