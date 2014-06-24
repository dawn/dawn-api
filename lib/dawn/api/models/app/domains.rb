require 'dawn/api/base_api'
require 'dawn/api/models/domain'

module Dawn #:nodoc:
  class App #:nodoc:
    class Domains #:nodoc:
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
      # @return [Array<Dawn::Domain>]
      ###
      def to_a
        all
      end

      ###
      # @overload each { |domain| do_stuff_with_domain }
      ###
      def each(&block)
        all.each(&block)
      end

      ###
      # @return [Dawn::Domain]
      ###
      def create(options)
        options.fetch(:domain)

        Domain.new(post(
          path: "/apps/#{app.id}/domains",
          body: options.to_json
        )["domain"]).tap { |d| d.app = @app }
      end

      ###
      # @return [Array<Dawn::Domain>]
      ###
      def all(options={})
        get(
          path: "/apps/#{app.id}/domains",
          query: options
        ).map { |hsh| Domain.new(hsh["domain"]).tap { |d| d.app = @app } }
      end

      ###
      # @return [Dawn::Domain]
      ###
      def find(options)
        Domain.find(options).tap { |d| d.app = @app }
      end

      def destroy(options)
        Domain.destroy(options)
      end
    end
  end
end
