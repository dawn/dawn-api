require 'dawn/api/base_api'

module Dawn
  class Account
    include BaseApi

    def initialize(hsh)
      @data = hsh
    end

    # @type [String]
    data_key :id, write: false
    # @type [Integer]
    data_key :created_at, write: false
    # @type [Integer]
    data_key :updated_at, write: false
    # @type [String]
    data_key :username
    # @type [String]
    data_key :email
    # @type [String]
    data_key :api_key, write: false

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

    def save
      update(account: @data)
    end

    def self.current(options={})
      new get(
        path: "/account",
        query: options
      )["user"]
    end
  end
end
