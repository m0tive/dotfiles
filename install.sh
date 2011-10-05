#!/bin/sh

VERSION="dotfiles_install_sh 0.0.0"

PREFIX=$HOME
FORCE=0
FILES=0
DRYRUN=0

NAME="`basename $0 .sh`.sh"
USAGE="Usage: $NAME [options] [file ..]"

# Process command arguments loop #{{{
for i in "$@"; do
	case $i in
		--prefix=*) PREFIX=`echo $i | cut -d '=' -f 2` ;;
		--prefix) PREFIX= ;;
		--force | -f) FORCE=1 ;;
		--dry-run | -n) DRYRUN=1 ;;

		--version) echo $VERSION
			exit 0 ;;

		--help | -h)
			echo $VERSION
			echo $USAGE
			echo
			echo "  -f, --force      overwrite existing files"
			echo "  -h, --help       show this help"
			echo "  -n, --dry-run    print out what will happen"
			echo "      --prefix=DIR directory to install into"
			echo "      --version    display version number"
			echo
			exit 0 ;;

		-*)
			echo "$NAME: unknown option $i" >&2
			echo "Try \`$NAME --help' for more information" >&2
			exit 1
			;;
		*) FILES=1
			;;
	esac
done
#}}}

function install {
	FLAG=
	if [ $FORCE != 0 ]; then
		FLAG+=f
	else
		FLAG+=i
	fi

	if [ $DRYRUN != 0 ]; then
		echo cp -$FLAG \"./$*\" \"$PREFIX/.$*\"
	else
		echo cp -v$FLAG \"./$*\" \"$PREFIX/.$*\"
	fi
}

function process {
	case "$*" in
		-* | install.* | *.* | cygwin) ;;

		*)
			if [ ! -e "./$*" ]; then
				echo "unkown file '$*'" >&2
				return
			fi
			install $*
			;;
	esac
}

pushd . &>/dev/null
DOTFILES=`dirname $0`
cd $DOTFILES
echo "cd to $DOTFILES"

if [ $FILES != 0 ]; then
	for i in "$@"; do process $i; done
else
	for i in `ls`; do process $i; done
fi

echo -n "return to "
popd
