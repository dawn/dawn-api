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
      @data = get(
        path: "/domains/#{id}",
        query: options
      )["domain"]
    end

    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    def self.id_param(options)
      id = options.delete(:id) ||
      options.delete(:name) ||
      options.delete(:uri) ||
      options.delete(:url) ||
      raise
    end

    def self.find(options)
      id = id_param(options)

      new get(
        path: "/domains/#{id}",
        query: options
      )["domain"]
    end

    def self.destroy(options)
      id = id_param(options)

      delete(
        path: "/domains/#{id}",
        query: options
      )
    end

  end
end
