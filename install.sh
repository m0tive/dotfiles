#!/bin/sh

PREFIX=$HOME
FORCE=0
FILES=0

for i in "$@"; do
	case $i in
		--prefix=*) PREFIX=`echo $i | cut -d '=' -f 2`
			;;
		--force | -f)
			FORCE=1
			;;
		-*) echo "unknown option '$i'" >&2
			exit 1
			;;
		*) FILES=1
			;;
	esac
done

#echo prefix \"$PREFIX\"
#[ $FORCE != 0 ] && echo force

function do_install {
	FLAG="-vi"
	[ $FORCE != 0 ] && FLAG+=f
	echo mv $FLAG \"./$*\" \"$PREFIX/.$*\"
}

function install {
	case "$*" in
		-* | install.* | *.*) ;;

		*)
			if ! ls "./$*" &>/dev/null; then
				echo "unkown file '$*'" >&2
				exit 1
			fi
			do_install $*
			;;
	esac
}

if [ $FILES != 0 ]; then
	for i in "$@"; do install $i; done
else
	for i in `ls -1`; do install $i; done
fi

