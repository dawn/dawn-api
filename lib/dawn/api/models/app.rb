require 'dawn/api/hosts'
require 'dawn/api/base_api'
require 'dawn/api/models/app/env'
require 'dawn/api/models/app/gears'
require 'dawn/api/models/app/drains'
require 'dawn/api/models/app/domains'
require 'dawn/api/models/app/releases'

module Dawn
  class App

    include BaseApi

    attr_reader :data
    attr_reader :env

    def initialize(hsh)
      @data = hsh
      @env = Env.new(self, @data.delete("env"))
    end

    data_key :id
    data_key :created_at
    data_key :updated_at
    data_key :name
    data_key :formation
    data_key :git

    def gears
      @gears ||= Gears.new self
    end

    def drains
      @drains ||= Drains.new self
    end

    def domains
      @domains ||= Domains.new self
    end

    def releases
      @releases ||= Releases.new self
    end

    def refresh(options={})
      @data = get(
        path: "/apps/#{id}",
        query: options
      )["app"]
    end

    def update(options={})
      options.fetch(:app)

      @data = patch(
        path: "/apps/#{id}",
        body: options.to_json
      )["app"]
    end

    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    def run(options={})
      self.class.run(options.merge(id: id))
    end

    def logs(options={})
      self.class.logs(options.merge(id: id))
    end

    def scale(options={})
      self.class.scale(options.merge(id: id))
    end

    def restart(options={})
      self.class.restart(options.merge(id: id))
    end

    def self.id_param(options)
      options.delete(:id) ||
      options.delete(:name) ||
      raise
    end

    def self.create(options)
      options.fetch(:app)

      new post(
        path: "/apps",
        body: options.to_json
      )["app"]
    end

    def self.all(options={})
      get(
        path: "/apps",
        query: options
      ).map { |d| new d["app"] }
    end

    def self.find(options)
      id = id_param(options)

      new get(
        path: "/apps/#{id}",
        query: options
      )["app"]
    end

    def self.update(options)
      id = id_param(options)
      options.fetch(:app)

      new patch(
        path: "/apps/#{id}",
        body: options.to_json
      )["app"]
    end

    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/apps/#{id}",
        query: options
      )
    end

    def self.restart(options={})
      id = id_param(options)

      post(
        path: "/apps/#{id}/gears/restart",
        body: options.to_json
      )
    end

    def self.logs(options={})
      id = id_param(options)

      url = get(
        path: "/apps/#{id}/logs",
        query: options
      )["logs"]

      "http://#{Dawn.log_host}#{url}"
    end

    def self.scale(options={})
      id = id_param(options)
      options.fetch(:app).fetch(:formation)

      post(
        path: "/apps/#{id}/scale",
        body: options.to_json
      )
    end

    def self.run(options={})
      id = id_param(options)
      options.fetch(:command)

      post(
        path: "/apps/#{id}/run",
        body: options.to_json
      )
    end

  end
end
