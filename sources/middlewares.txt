.. vim: set expandtab ts=2 sw=2 nowrap ft=rst fenc=utf-8 ff=unix :

Middlewares
===========

.. list-table:: Middlewares
  :widths: 5 10 10 10 10
  :header-rows: 1

  * -
    - Ruby
    - Perl
    - Java
    - JRuby-Netty
  * - Programming Language
    - Ruby
    - Perl
    - Java
    - Ruby
  * - Application Server
    - Unicorn
    - Starlet
    - Jetty
    - Netty
  * - Web Server Interface
    - Rack
    - PSGI/Plack
    - Servlet
    - Netty
  * - Web Application Framework
    - Sinatra
    - Amon2::Lite
    - htmleasy based on resteasy
    - -
  * - MySQL Driver
    - mysql2
    - DBD::mysql
    - Connector/J
    - ActiveRecord-JDBC
  * - SQL Builder
    - Arel
    - SQL::Maker
    - Querydsl
    - Arel
  * - YAML Loader
    - yaml
    - YAML::XS
    - SnakeYAML
    - yaml
  * - JSON Builder
    - json
    - JSON::XS
    - JSON.simple
    - json
  * - Documentation
    - YARD yard-sinatra
    - POD
    - JavaDoc
    - YARD
  * - Unit testing
    - rspec rake-test
    - | Test::Unit
      | Test::WWW::Mechanize::PSGI
    - TestNG Spock
    - rspec
  * - CI
    - Travis CI
    - -
    - Travis CI
    - Travis CI
  * - Memcached driver
    - memcached
    - Cache::Memcached::Fast
    - xmemcached
    - jruby-memcache-client
  * - Profiler
    - RubyProf -> llprof
    - Devel::NYTProf
    - Something which uses JVMTI(not used yet)
    - jruby-prof
  * - Auto reload on developing
    - shotgun
    - Plack::Loader::Shotgun
    - Gradle Jetty Plugin
    - -
  * - Show stack trace on HTML
    - Sinatra Rack::ShowExceptions
    - | Amon2::Lite
      | Plack::Middleware::HTTPExceptions
    - -
    - -
  * - Security
    - rack-protection
    - Amon2::Plugin::Web::CSRFDefender.pm
    - -
    - -
  * - DI container
    - -
    - -
    - Guice
    - -
  * - Module management
    - rvm gem
    - cpanm
    - Gradle Ivy
    - rvm gem
  * - A/B test
    - split
    - -
    - -
    - -
