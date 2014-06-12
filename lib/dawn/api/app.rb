require 'dawn/api/hosts'
require 'dawn/api/base_api'
require 'dawn/api/app/env'
require 'dawn/api/app/gears'
require 'dawn/api/app/drains'
require 'dawn/api/app/domains'
require 'dawn/api/app/releases'

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

    def restart(options={})
      gears.restart options
    end

    def refresh(options={})
      @data = json_request(
        expects: 200,
        method: :get,
        path: "/apps/#{id}",
        query: options
      )["app"]
    end

    def logs(options={})
      url = json_request(
        expects: 200,
        method: :get,
        path: "/apps/#{id}/logs",
        query: options
      )["logs"]
      "http://#{Dawn.log_host}#{url}"
    end

    def update(options={})
      @data = json_request(
        expects: 200,
        method: :patch,
        path: "/apps/#{id}",
        body: { name: name }.merge(options).to_json
      )["app"]
    end

    def scale(formation)
      request(
        expects: 200,
        method: :post,
        path: "/apps/#{id}/scale",
        body: { formation: formation }.to_json
      )
    end

    def destroy(options={})
      request(
        expects: 200,
        method: :delete,
        path: "/apps/#{id}",
        query: options
      )
    end

    def run(options={})
      request(
        expects: 200,
        method: :post,
        path: "/apps/#{id}/run",
        body: options.to_json
      )
    end

    def self.all(options={})
      json_request(
        expects: 200,
        method: :get,
        path: "/apps",
        query: options
      ).map { |hsh| new(hsh["app"]) }
    end

    def self.create(options)
      new json_request(
        expects: 200,
        method: :post,
        path: '/apps',
        body: options.to_json
      )["app"]
    end

    def self.find(options)
      path = "/apps/#{options.delete(:id) || options.delete(:name)}"
      new json_request(
        expects: 200,
        method: :get,
        path: path,
        query: options
      )["app"]
    end

    def self.destroy(options)
      find(options).destroy
    end

  end
end
