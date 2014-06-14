require 'dawn/api/base_api'

module Dawn
  class Drain

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
      @data = get(
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    def destroy(options)
      Drain.destroy(options.merge(id: id))
    end

    def self.all(options={})
      get(
        path: "/drains",
        query: options
      ).map { |hsh| new hsh["drain"] }
    end

    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/drains/#{id}",
        query: options
      )
    end

  end
end
