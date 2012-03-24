# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require './lib/api-server/users-handler'

module ApiServer
  class UsersGetHandler < UsersHandler
    # User count.
    get '/v:version/users/count.?:format?' do |version, format|
      filtered_params = {
        # meta parameters
        :version    => version.to_int || 1,
        :format     => format.intern || :json,
      }

      halt 400 unless filtered_params[:format] == :json
      halt 400 unless filtered_params[:version] == 1

      users_t = Arel::Table.new(:users)
      users_q = users_t.project(users_t[:id].count.as('user_count'))

      user_count = connection.select_one(users_q.to_sql)
      respond_json(user_count)
    end

    # Select records.
    get %r{/v(\d+)/users(/(\d+))?(\.(\w+))?} do |version, _, id, _, format|
      filtered_params = {
        :fields     => params[:fields] || '*',
        :orderby    => params[:orderby],
        :offset     => params[:offset].to_int,
        :limit      => params[:limit].to_int,
        :id         => id.to_int,
        # meta parameters
        :version    => version.to_int || 1,
        :format     => format.intern || :json,
      }

      halt 400 unless filtered_params[:format] == :json
      halt 400 unless filtered_params[:version] == 1

      respond_users(filtered_params)
    end
  end
end
