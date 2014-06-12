require 'dawn/api/base_api'

module Dawn
  class Gear

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
    data_key :name
    data_key :uptime
    data_key :proctype
    data_key :number
    data_key :app_id, "app/id"

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def restart(options={})
      request(
        expects: 200,
        method: :post,
        path: "/gears/#{id}/restart",
        query: options
      )
    end

    def update(options={})
      request(
        expects: 200,
        method: :post,
        path: "/gears/#{id}",
        body: options.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/gears/#{id}",
        query: options
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/gears",
        query: options
      ).map { |hsh| new hsh["gear"] }
    end

    def self.find(options)
      id = options.delete(:id)

      new json_request(
        expects: 200,
        method: :get,
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

  end
end
