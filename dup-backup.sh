#!/bin/bash
# Rex Tsai <chihchun@kalug.linux.org.tw>
# Ox0spy <Ox0spy@gmail.com> changed for my environment

BKDIR=$HOME/Dropbox
KEY=D75EAD37
# OP=incremental
# OP=full
# OP=collection-status
# OP=cleanup
# OP="remove-older-than time"
# OP=list-current-files
# OP=verify
OP=$1
TARGET=$2

set -e

function askpass()
{
    if [ -z $PASSPHRASE ] ; then
        echo -n "GnuPG passphrase: "
        read -s PASSPHRASE
        export PASSPHRASE
    fi
}

if [ ! -d $BKDIR ] ; then
    echo "$BKDIR does not exist"
    exit -1
fi

askpass

if [ x"$TARGET" == x ] || [ $TARGET == 'Dropbox' ] ; then
nice -n 19 \
    duplicity ${OP} --encrypt-key ${KEY} \
    /media/share/backup \
    file://${BKDIR}/workspace
fi
