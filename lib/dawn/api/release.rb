require 'dawn/api/base_api'

module Dawn
  class Release

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
    data_key :image
    data_key :app_id, "app/id"

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/releases/#{id}",
        query: options
      )["release"]
    end

    def update(options={})
      request(
        expects: 200,
        method: :post,
        path: "/releases/#{id}",
        body: options.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/releases/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/releases",
        query: options
      ).map { |hsh| new hsh["release"] }
    end

    def self.find(options={})
      id = options.delete(:id)

      new json_request(
        expects: 200,
        method: :get,
        path: "/releases/#{id}",
        query: options
      )["release"]
    end

    def self.destroy(options={})
      find(options).destroy
    end

  end
end
