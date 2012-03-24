# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require './lib/api-server/users-handler'

module ApiServer
  class UsersPostHandler < UsersHandler
    # Insert a new record.
    def execute_insert_query(filtered_params)
      table = Arel::Table.new(:users)
      manager = Arel::InsertManager.new(Arel::Table.engine)
      manager.into(table)

      manager.values = Arel::Nodes::Values.new([filtered_params[:name]])
      manager.columns << table[:name]

      query_execute(manager)
    end

    def insert_user(filtered_params)
      result = execute_insert_query(filtered_params)
      respond_users({
        :id => connection.last_inserted_id(result),
        :fields => '*',
      })
    end

    def handler_post_users
      filtered_params = {
        :name       => params[:name].intern,
        # meta parameters
        :format     => params[:format].intern || :json,
      }

      if filtered_params[:name]
        insert_user(filtered_params)
      else
        'name is required'
      end
    end

    # Insert a new record.
    post '/v1/users.?:format?' do
      handler_post_users
    end
  end
end
