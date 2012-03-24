# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require './lib/api-server/users-handler'

module ApiServer
  class UsersDeleteHandler < UsersHandler
    def handler_delete_users
      p = {
        # meta parameters
        :version    => params[:version].to_int || 1,
        :format     => params[:format].intern || :json,
        :supress_rc => true & params[:supress_response_codes]
      }
    end

    # Delete records.
    delete '/v:version/users.?:format?' do
      handler_delete_users
    end

    # Delete a record.
    delete '/v:version/users.?:format?/:id' do
      handler_delete_user
    end

    def handler_delete_user
      filtered_params = {
        :id         => params[:id].to_int,
        # meta parameters
        :version    => params[:version].to_int || 1,
        :format     => params[:format].intern || :json,
        :supress_rc => params[:supress_response_codes].intern
      }

      # respond before delete
      respond_users({
        :id => filtered_params[:id],
        :fields => '*',
      })

      table = Arel::Table.new(:users)
      manager = Arel::DeleteManager.new(Arel::Table.engine)

      manager.from table
      manager.where table[:id].eq(filtered_params[:id])

      result = self.query_execute(manager)
    end
  end
end
