#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
case $1 in
  release)  plackup -S Starlet -p 8080 app.psgi ;;
  debug)    plackup -S Starlet -p 8080 -L Shotgun app.psgi ;;
  *)        echo "Usage: $0 release|debug" ;;
esac
