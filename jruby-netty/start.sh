#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
case $1 in
  release)  ruby webserver.rb ;;
  debug)    ruby webserver.rb ;;
  *)        echo "Usage: $0 release|debug" ;;
esac
