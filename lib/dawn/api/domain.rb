require 'dawn/api/base_api'

module Dawn
  class Domain

    include BaseApi

    attr_reader :data
    attr_writer :app

    def initialize(data)
      @app = nil
      @data = data
    end

    data_key :id
    data_key :created_at
    data_key :updated_at
    data_key :url
    data_key :app_id, "app/id"

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/domains/#{id}",
        query: options
      )["domain"]
    end

    def update(options={})
      @data = json_request(
        expects: 200,
        method: :post,
        path: "/domains/#{id}",
        body: options.to_json
      )["domain"]
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/domains/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/domains",
        query: options
      ).map { |hsh| new hsh["domain"] }
    end

    def self.find(options)
      id = options.delete(:id)

      new json_request(
        expects: 200,
        method: :get,
        path: "/domains/#{id}",
        query: options
      )["domain"]
    end

  end
end
