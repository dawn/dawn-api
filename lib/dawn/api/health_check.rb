module Dawn #:nodoc:
  module API #:nodoc:
    ###
    # Verifies that the server is running.
    ###
    def self.health_check
      Dawn.request(
        expects: 200,
        method: :get,
        path: "/healthcheck"
      )
    end
  end
end
