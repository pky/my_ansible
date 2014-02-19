#!/bin/bash

ZSHVERSION=5.0.2
INSTALL_ZSH="yes"

if [ $# -ge 1 ]; then
	ZSHVERSION=$1
fi

if [ -e /usr/local/bin/zsh ]; then
	NOW_ZSH=`/usr/local/bin/zsh --version | grep $ZSHVERSION`
	if [ -n "$NOW_ZSH" ]; then
		INSTALL_ZSH="no"
	fi
fi

if [ $INSTALL_ZSH = "yes" ]; then
cd $TMPDIR
wget http://sourceforge.net/projects/zsh/files/zsh/$ZSHVERSION/zsh-$ZSHVERSION.tar.gz/download
tar xf zsh-$ZSHVERSION.tar.gz
cd zsh-$ZSHVERSION
./configure --prefix=/usr/local
make
sudo make install
sudo chmod 666 /etc/shells
echo "/usr/local/bin/zsh" >> /etc/shells
sudo chmod 644 /etc/shells
chsh -s /usr/local/bin/zsh $INSTALLUSER

cd $TMPDIR
rm -f zsh-$ZSHVERSION.tar.gz
rm -rf zsh-$ZSHVERSION
fi
