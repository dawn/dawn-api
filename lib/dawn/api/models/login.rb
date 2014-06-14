require 'dawn/api/base_api'

module Dawn
  class User

    include BaseApi

    def self.login(options={})
      post(
        path: '/login',
        body: options.to_json
      )
    end

  end
end
