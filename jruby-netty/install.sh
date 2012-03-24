#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
source "$HOME/.rvm/scripts/rvm"
declare rvm_make_flags="-j 4"
rm Gemfile.lock
rm -rf vendor

rvm install jruby-1.6.6
rvm --create use jruby-1.6.6@apiserver
gem install bundler --no-ri --no-rdoc
bundle
rvm rvmrc trust

# Download netty jar
curl -O http://netty.io/downloads/netty-3.3.1.Final-dist.tar.bz2
tar xvfj netty-3.3.1.Final-dist.tar.bz2
mv netty-3.3.1.Final/jar/netty-3.3.1.Final.jar .
rm -rf netty-3.3.1.Final
