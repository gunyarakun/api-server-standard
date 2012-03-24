# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */
require 'sinatra/base'
require 'sinatra/json'

require './lib/api-server/error'

module ApiServer
  class Handler < Sinatra::Base
    helpers Sinatra::JSON
    helpers do
      include Rack::Utils

      # Execute query
      #
      # @param [Arel::SelectManager] query_obj An Arel query.
      # @return [Mysql2::Result] the result of the query.
      def query_execute(query_obj)
        query = query_obj.to_sql
        self.connection.execute(query)
      end

      # Fetch DB connection.
      #
      # @return [Object] MySQL DB connection.
      def connection
        ActiveRecord::Base.connection
      end

      # Respond JSON with status and response time.
      #
      # @param [Object] body response body
      # @param [Object] response_code
      # @param [Object] error_code
      # @param [Object] error_message
      # @param [Object] error_more_info
      def respond_json(body, response_code = 200,
                       error_code = 0, error_message = nil, error_more_info = nil)
        r = {}
        r[:body] = body unless body.nil?
        r[:code] = error_code if error_code
        r[:message] = error_message if error_message
        r[:more_info] = error_more_info if error_more_info
        if params.has_key?('supress_response_codes')
          r[:response_code] = response_code
          status 200
        else
          status response_code
        end
        json r
      end
    end

    # method parameter to REQUEST_METHOD.
    before do
      if request.get? and params.has_key?('method')
        case params['method']
        when 'post', 'put', 'delete'
          request.env['REQUEST_METHOD'] = params['method'].upcase
        end
      end
    end

    disable :show_exceptions

    # Output error by JSON unless text/html preferred.
    error ApiServer::Error do
      e = request.env['sinatra.error']
      if request.preferred_type == 'text/html'
        raise e
      else
        respond_json(nil, e.http_code, e.code, e.message, e.more_info)
      end
    end

    # JSON to HTML if text/html is preferred.
    after do
      if content_type == 'application/json' and
         request.preferred_type == 'text/html'
        content_type 'text/html; charset=utf-8'
        "<body>#{escape(response.body)}</body>"
      end
    end
  end
end
