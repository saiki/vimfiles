#!/bin/sh

if [ -d $HOME/.vim ]; then
	mv $HOME/.vim $HOME/.vim.$(date +%Y%m%d)
fi
current=`pwd`
cd `dirname $0`

ln -s `pwd` $HOME/.vim

cd $current
