#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e -u
mysql -u root < ddl.sql
mysql -u root apiserver < dml.sql
