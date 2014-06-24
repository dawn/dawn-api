require 'dawn/api/base_api'
require 'dawn/api/models/release'

module Dawn #:nodoc:
  class App #:nodoc:
    class Releases #:nodoc:
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
      # @return [Array<Dawn::Release>]
      ###
      def to_a
        all
      end

      ###
      # @overload each { |release| do_stuff_with_release }
      ###
      def each(&block)
        all.each(&block)
      end

      ###
      # @return [Dawn::Release]
      ###
      def create(options={})
        #options.fetch(:release)

        Release.new(post(
          path: "/apps/#{app.id}/releases",
          body: options.to_json
        )["release"]).tap { |d| d.app = @app }
      end

      ###
      # @return [Array<Dawn::Release>]
      ###
      def all(options={})
        get(
          path: "/apps/#{app.id}/releases",
          query: options
        ).map { |hsh| Release.new(hsh["release"]).tap { |d| d.app = @app } }
      end

      ###
      # @return [Dawn::Release]
      ###
      def find(options={})
        Release.find(options).tap { |d| d.app = @app }
      end
    end
  end
end
