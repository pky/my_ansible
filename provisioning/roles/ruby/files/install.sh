#!/bin/bash

RBE=/usr/local/rbenv/bin/rbenv
RUBYVERSION=2.0.0-p353

if [ $# -ge 1 ]; then
	RUBYVERSION=$1
fi	

#ruby
if [ ! -e /usr/local/rbenv/shims/ruby ]; then

#install rbenv
cd /usr/local
sudo git clone git://github.com/sstephenson/rbenv.git rbenv
if [ ! -d /usr/local/rbenv/shims ]; then sudo mkdir /usr/local/rbenv/shims ;fi
if [ ! -d /usr/local/rbenv/versions ]; then sudo mkdir /usr/local/rbenv/versions ;fi
sudo chgrp -R wheel rbenv
sudo chmod -R g+rwxXs rbenv

sudo chmod 666 /etc/profile
echo "export RBENV_ROOT=/usr/local/rbenv" >> /etc/profile
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile
echo 'eval "$(rbenv init -)"' >> /etc/profile
sudo chmod 644 /etc/profile

# reconfig
case $SHELL in
  *bash*) source /etc/profile ;;
  *zsh*)  source $HOME/.zshrc ;;
esac
 
# install ruby-build
if [ ! -d /usr/local/rbenv/plugins ]; then sudo mkdir /usr/local/rbenv/plugins ;fi
cd /usr/local/rbenv/plugins
sudo git clone git://github.com/sstephenson/ruby-build.git
sudo chgrp -R wheel ruby-build
sudo chmod -R g+rwxs ruby-build
cd ruby-build
sudo ./install.sh
 
# install ruby
$RBE install $RUBYVERSION
$RBE rehash
$RBE global $RUBYVERSION

fi

