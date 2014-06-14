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
      @data = request(
        expects: 200,
        method: :get,
        path: "/releases/#{id}",
        query: options
      )["release"]
    end

    def self.all(options={})
      get(
        path: "/releases",
        query: options
      ).map { |hsh| new hsh["release"] }
    end

    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/releases/#{id}",
        query: options
      )["release"]
    end

  end
end
