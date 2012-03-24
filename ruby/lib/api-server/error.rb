# vim: set expandtab ts=2 sw=2 nowrap ft=ruby ff=unix : */

module ApiServer
  class Error < StandardError
    ERRORS = {
      :user_not_found => {
        :code => 1,
        :http_code => 404,
        :message => 'Specified user is not found',
        :more_info => 'http://www.example.com/error/1',
      }
    }

    attr_reader :code, :http_code, :more_info

    def initialize(error_symbol)
      e = ERRORS[error_symbol]
      @code = e[:code]
      @http_code = e[:http_code]
      @more_info = e[:more_info]
      super(e[:message])
    end
  end
end
