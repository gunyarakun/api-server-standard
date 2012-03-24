#!/bin/sh
# vim: set expandtab ts=2 sw=2 nowrap ft=sh ff=unix : */
set -e
pip install --upgrade sphinx sphinx-http-domain sphinxjp.themes.dotted
pip install -e 'git+git://github.com/michaeljones/sphinx-to-github.git#egg=sphinx-to-github'
