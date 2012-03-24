#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
case $1 in
  release)  ./gradlew -Djetty.reload=manual jettyRunWar ;;
  debug)    ./gradlew -Djetty.reload=automatic -Djetty.scanIntervalSeconds=10 jettyRun ;;
  *)        echo "Usage: $0 release|debug" ;;
esac
