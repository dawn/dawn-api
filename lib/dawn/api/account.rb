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
      @data = json_request(
        method: :get,
        expects: 200,
        path: "/account",
        query: options.to_json
      )["account"]
    end

    def update(options={})
      @data = json_request(
        method: :post,
        expects: 200,
        path: "/account",
        body: options.to_json
      )["account"]
    end

    def self.current(options={})
      account = new({})
      account.refresh(options)
      account
    end

  end
end
