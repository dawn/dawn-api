require 'dawn/api/base_api'

module Dawn #:nodoc:
  class User #:nodoc:
    include BaseApi

    ###
    # @param [Hash] options
    ###
    def self.login(options={})
      post(
        path: '/login',
        body: options.to_json
      )
    end
  end
end
