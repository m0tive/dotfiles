
ADDPATH=$HOME/.addToPath

if [ -f $ADDPATH ] ; then
	ADDPATH=". $ADDPATH"

	$ADDPATH /opt/local/bin
	$ADDPATH /opt/local/sbin

	$ADDPATH /public/bin

	$ADDPATH $HOME/.bbin
	$ADDPATH $HOME/bin
fi

LOCALPROFILE=$HOME/.profile.local

if [ -f $LOCALPROFILE ] ; then
	cp $LOCALPROFILE $LOCALPROFILE.bak
	. $LOCALPROFILE
fi

LOCALBASHRC=$HOME/.bashrc.local

[ -f $LOCALBASHRC ] && cp $LOCALBASHRC $LOCALBASHRC.bak
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
