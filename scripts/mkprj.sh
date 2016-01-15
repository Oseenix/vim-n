#!/bin/sh

prjdir=

if [ $# = 0 ]
then
    prjdir="vimprj"
else
    prjdir=$1
fi
echo $prjdir

mkfiletags.sh $prjdir
mkcodetags.sh $prjdir

exit 0
