#!/bin/bash

EMACSVERSION=24.3

if [ $# -ge 1 ]; then
	RUBYVERSION=$1
fi

#emacs
if [ -e /usr/local/bin/emacs ]; then
	NOW_EMACS=`/usr/local/bin/emacs --version | grep $EMACSVERSION`
	if [ -n "$NOW_EMACS" ]; then
		INSTALL_EMACS="no"
	fi
fi

if [ $INSTALL_EMACS = "yes" ]; then
cd $TMPDIR
wget http://ftp.gnu.org/pub/gnu/emacs/emacs-24.3.tar.xz
tar xf emacs-$EMACSVERSION.tar.xz
cd emacs-$EMACSVERSION
./configure --without-x
make
sudo make install

cd $TMPDIR
rm -f emacs-$EMACSVERSION.tar.gz
rm -rf emacs-$EMACSVERSION

fi

