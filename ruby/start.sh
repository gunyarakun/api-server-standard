#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
case $1 in
  release)  bundle exec vendor/bundle/ruby/1.9.1/bin/unicorn -E deployment -c unicorn.conf ;;
  debug)    bundle exec vendor/bundle/ruby/1.9.1/bin/shotgun -E development --port=8080 config.ru ;;
  *)        echo "Usage: $0 release|debug" ;;
esac
