# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require 'yaml'
require 'sinatra/base'
require 'active_record'

require './lib/api-server/users-post-handler'
require './lib/api-server/users-get-handler'
require './lib/api-server/users-put-handler'
require './lib/api-server/users-delete-handler'
require './lib/api-server/error'

config = YAML.load_file('../config.yaml')
ActiveRecord::Base.establish_connection(config['database'])
Arel::Table.engine = Arel::Sql::Engine.new(ActiveRecord::Base)

class NilClass
  # Returns nil.
  # See String#intern
  #
  # @return [NilObject] nil.
  def intern
    nil
  end

  # Returns nil.
  # See String#to_int.
  #
  # @return [NilObject] nil.
  def to_int
    nil
  end
end

class String
  # Convert the string to the number.
  # See NilClass#to_int.
  #
  # @return [Number] the number converted from String
  def to_int
    self.to_i
  end
end

module ApiServer
  class Application < Sinatra::Base
    use ApiServer::UsersPostHandler
    use ApiServer::UsersGetHandler
    use ApiServer::UsersPutHandler
    use ApiServer::UsersDeleteHandler
#    disable :show_exceptions
  end
end
