#!/bin/bash

EMACS_VER=24.5

mkdir -p $HOME/tmp
cd $HOME/tmp
curl -O http://ftp.gnu.org/pub/gnu/emacs/emacs-${EMACS_VER}.tar.xz
git clone git@gist.github.com:1d91107b311b63b57529.git
mv 1d91107b311b63b57529 inline
tar xfJ emacs-${EMACS_VER}.tar.xz
cd emacs-${EMACS_VER}
patch -p1 < ../inline/emacs-24.5-inline.patch
./configure --with-ns --without-x
make bootstrap
make install

