

ADDTOPATH="/opt/local/bin /opt/local/sbin $HOME/bin $HOME/.bbin /public/bin"
for DIR in $ADDTOPATH ; do
	[ -d $DIR ] && [ ! "`echo $PATH | grep -F "$DIR"`" ] && export PATH=$DIR:$PATH
done

export LIBRARY_PATH=$HOME/lib:$LIBRARY_PATH

LOCALPROFILE=$HOME/.profile.local

if [ -f $LOCALPROFILE ] ; then
	cp $LOCALPROFILE $LOCALPROFILE.bak
	. $LOCALPROFILE
fi

#echo $PATH

LOCALBASHRC=$HOME/.bashrc.local

[ -f $LOCALBASHRC ] && cp $LOCALBASHRC $LOCALBASHRC.bak
[ `uname -s` != "Linux" ] && [ -f $HOME/.bashrc ] && . $HOME/.bashrc
