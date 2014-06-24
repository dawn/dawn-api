require 'dawn/api/base_api'

module Dawn
  class Account

    include BaseApi

    def initialize(hsh)
      @data = hsh
    end

    data_key :id
    data_key :created_at
    data_key :updated_at
    data_key :username
    data_key :email
    data_key :api_key

    def refresh(options={})
      @data = get(
        path: "/account",
        query: options
      )["user"]
    end

    def update(options={})
      options.fetch(:account)

      @data = patch(
        path: "/account",
        body: options.to_json
      )["user"]
    end

    def self.current(options={})
      new get(
        path: "/account",
        query: options
      )["user"]
    end

  end
end
