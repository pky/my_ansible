#!/bin/sh

cd /var/lib/redmine
BUNDLE=/usr/local/rbenv/shims/bundle
ENV=production
CONF=config/unicorn_redmine.rb
#$BUNDLE exec unicorn_rails -E $ENV -c $CONF -p 8080
$BUNDLE exec unicorn_rails -E $ENV -c $CONF
