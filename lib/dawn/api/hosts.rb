module Dawn #:nodoc:
  ###
  # @return [String]
  ###
  def self.dawn_scheme
    ENV["DAWN_SCHEME"] || "http"
  end

  ###
  # @return [String]
  ###
  def self.dawn_host
    ENV["DAWN_HOST"] || "dawn.dev"
  end

  ###
  # @return [String]
  ###
  def self.dawn_api_host
    ENV["DAWN_API_HOST"] || "api.#{dawn_host}"
  end

  ###
  # @return [String]
  ###
  def self.git_host
    ENV["DAWN_GIT_HOST"] || "#{dawn_host}:2201"
  end

  ###
  # @return [String]
  ###
  def self.log_host
    ENV["DAWN_LOG_HOST"] || "#{dawn_host}:8001"
  end
end
