#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
bundle exec vendor/bundle/ruby/1.9.1/bin/rspec spec
