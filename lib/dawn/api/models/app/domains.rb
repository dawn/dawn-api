require 'dawn/api/base_api'
require 'dawn/api/models/domain'

module Dawn
  class App
    class Domains

      include BaseApi
      include Enumerable

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def to_a
        all
      end

      def each(&block)
        all.each(&block)
      end

      def create(options)
        options.fetch(:domain)

        Domain.new(post(
          path: "/apps/#{app.id}/domains",
          body: options.to_json
        )["domain"]).tap { |d| d.app = @app }
      end

      def all(options={})
        get(
          path: "/apps/#{app.id}/domains",
          query: options
        ).map { |hsh| Domain.new(hsh["domain"]).tap { |d| d.app = @app } }
      end

      def find(options)
        Domain.find(options).tap { |d| d.app = @app }
      end

    end
  end
end
