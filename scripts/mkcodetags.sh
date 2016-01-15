#!/bin/sh

usage()
{
    echo "Usage: `basename $0` prjname"
    exit 1
}

if [ $# = 0 ]
then
    usage
fi

prjdir=./.$1
if [ ! -d $prjdir ]
then
    echo "create prjdir:$prjdir"
    mkdir -p $prjdir
fi

if [ -f $prjdir/cscope.files ]
then
    echo "Generation cscope..."
    #cscope -bkq -i $prjdir/cscope.files -f $prjdir/cscope.out
    cscope -Rbkq -i $prjdir/cscope.files -f $prjdir/cscope.out
    echo "Generation tags..."
    ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -L $prjdir/cscope.files -f  $prjdir/tags
    #ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f $prjdir/tags
    echo "code tags update success!"
else
    echo "cscope.files not found!"
    exit 1
fi

exit 0
