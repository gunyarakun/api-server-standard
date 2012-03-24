# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require 'rubygems'
require 'bundler/setup'

require './lib/api-server/application'
require 'rack/protection'

use Rack::Protection, :except => :session_hijacking
run ApiServer::Application
