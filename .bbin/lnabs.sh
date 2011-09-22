#!/bin/sh

[ ! $2 ] && exit 1

ln -s `readlink -f "$1"` $2
