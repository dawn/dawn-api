require 'dawn/api/base_api'
require 'dawn/api/models/drain'

module Dawn
  class App
    class Drains

      include BaseApi
      include Enumerable

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def each(&block)
        all.each(&block)
      end

      def create(options={})
        options.fetch(:drain)

        Drain.new(post(
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )["drain"]).tap { |d| d.app = @app }
      end

      def all(options={})
        get(
          path: "/apps/#{app.id}/drains",
          query: options
        ).map { |hsh| Drain.new(hsh["drain"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Drain.find(options).tap { |d| d.app = @app }
      end

    end
  end
end
