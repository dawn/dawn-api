require 'dawn/api/base_api'
require 'dawn/api/models/drain'

module Dawn #:nodoc:
  class App #:nodoc:
    class Drains #:nodoc:
      include BaseApi, Enumerable

      # @type [Dawn::App]
      attr_reader :app

      ###
      # @param [Dawn::App] app
      ###
      def initialize(app)
        @app = app
      end

      ###
      # @return [Array<Dawn::Drain>]
      ###
      def to_a
        all
      end

      ###
      # @overload each { |drain| do_stuff_with_drain }
      ###
      def each(&block)
        all.each(&block)
      end

      ###
      # @return [Dawn::Drain]
      ###
      def create(options={})
        options.fetch(:drain)

        Drain.new(post(
          path: "/apps/#{app.id}/drains",
          body: options.to_json
        )["drain"]).tap { |d| d.app = @app }
      end

      ###
      # @return [Array<Dawn::Drain>]
      ###
      def all(options={})
        get(
          path: "/apps/#{app.id}/drains",
          query: options
        ).map { |hsh| Drain.new(hsh["drain"]).tap { |d| d.app = @app } }
      end

      ###
      # @return [Dawn::Drain]
      ###
      def find(options={})
        Drain.find(options).tap { |d| d.app = @app }
      end

      def destroy(options)
        Drain.destroy(options)
      end
    end
  end
end
