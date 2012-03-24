#!/usr/bin/env ruby
# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
Dir::chdir('./ruby')
system("bundle exec rspec spec")
exit($?.exitstatus == 0)
