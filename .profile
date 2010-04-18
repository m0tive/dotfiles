
ADDPATH=$HOME/.addToPath

if [ -f $ADDPATH ] ; then
	ADDPATH=". $ADDPATH"

	$ADDPATH /opt/local/bin
	$ADDPATH /opt/local/sbin

	$ADDPATH $HOME/.bbin
	$ADDPATH $HOME/bin
fi

[ -f $HOME/.bashrc ] && . $HOME/.bashrc
