#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
source "$HOME/.rvm/scripts/rvm"
declare rvm_make_flags="-j 4"
declare -r ruby_version="1.9.3-p125"
rm Gemfile.lock
rm -rf vendor

declare -r uname=`uname`
case $uname in
  Darwin)  rvm install "$ruby_version" --with-gcc=clang ;;
  *)       rvm install "$ruby_version" ;;
esac

rvm --create use "$ruby_version@apiserver"
gem install bundler --no-ri --no-rdoc
bundle
rvm rvmrc trust
