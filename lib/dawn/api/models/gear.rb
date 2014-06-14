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
      @data = get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def restart(options={})
      self.class.restart(options.merge(id: id))
    end

    def destroy(options)
      self.class.destroy(options.merge(id: id))
    end

    def self.all(options={})
      get(
        path: "/gears",
        query: options
      ).map { |d| new d["gear"] }
    end

    def self.find(options)
      id = id_param(options)

      new get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def self.restart(options={})
      self.class.restart(options.merge(id: id))

      post(
        path: "/gears/#{id}/restart",
        query: options
      )
    end

    def self.destroy(options)
      id = id_param(options)

      delete(
        path: "/gears/#{id}",
        query: options
      )
    end

  end
end
