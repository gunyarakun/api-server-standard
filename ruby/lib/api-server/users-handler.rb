# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require './lib/api-server/handler'

module ApiServer
  class UsersHandler < Handler
    # Select records.
    def select(a)
      users_t = Arel::Table.new(:users)
      users_t = users_t.where(users_t[:id].eq(a[:id])) if a[:id]
      users_t = users_t.order(users_t[a[:orderby]].desc) if a[:orderby]
      users_t = users_t.take(a[:limit]) if a[:limit]
      users_t = users_t.skip(a[:offset]) if a[:offset]
      users_q = users_t.project(Arel.sql(a[:fields]))

      if a[:id]
        ret = connection.select_one(users_q.to_sql)
        raise Error, :user_not_found if ret.nil?
        ret
      else
        connection.select_rows(users_q.to_sql)
      end
    end

    # Respond user(s) info.
    def respond_users(filtered_params)
      users = select(filtered_params)
      if users.nil?
        # FIXME: set proper error_code
        respond_json(nil, 404, 0)
      else
        respond_json(users)
      end
    end
  end
end
