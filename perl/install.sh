#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
cpanm local::lib
export PERL_CPANM_OPT="-l ./extlib"
cpanm Starlet Amon2::Lite Amon2::Plugin::DBI JSON JSON::XS YAML::XS SQL::Maker DBD::mysql Plack::Loader::Shotgun Filesys::Notify::Simple

# Install modules for Filesys::Notify::Simple
uname=`uname`
case $uname in
  Darwin)  cpanm Mac::FSEvents ;;
  Linux)   cpanm Linux::Inotify2 ;;
  FreeBSD) cpanm IO::KQueue ;;
  *)       echo "Usage: $0 release|debug" ;;
esac
