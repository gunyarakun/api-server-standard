# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require './lib/api-server/users-handler'

module ApiServer
  class UsersPutHandler < UsersHandler
    # Update a record.
    put '/v:version/users.?:format?/:id' do
      filtered_params = {
        :id         => params[:id].to_int,
        :name       => params[:name],
        # meta parameters
        :version    => params[:version].to_int || 1,
        :format     => params[:format].intern || :json,
        :supress_rc => true & params[:supress_response_codes]
      }

      halt 401 unless filtered_params[:format] == :json
      halt 401 unless filtered_params[:version] == 1

      if filtered_params[:id] and filtered_params[:name]
        table = Arel::Table.new(:users)
        manager = Arel::UpdateManager.new(Arel::Table.engine)

        manager.table table
        manager.set [[table[:name], filtered_params[:name]]]
        manager.where table[:id].eq(filtered_params[:id])

        query_execute(manager)
        respond_users({
          :id => filtered_params[:id],
          :fields => '*',
        })
      else
        'id and name are required'
      end
    end
  end
end
