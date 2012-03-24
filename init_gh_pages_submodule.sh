#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
git submodule add -b gh-pages git@github.com:gunyarakun/api-server-standard.git doc/gh-pages
(cd doc/gh-pages; git submodule init; git submodule update)
