require 'dawn/api/version'
require 'base64'
require 'excon'
require 'netrc'

module Dawn

  HEADERS = {
    'Accept'                => 'application/json',
    'Content-Type'          => 'application/json',
    'Accept-Encoding'       => 'gzip',
    'User-Agent'            => "dawn/#{API::VERSION}",
    'X-Ruby-Version'        => RUBY_VERSION,
    'X-Ruby-Platform'       => RUBY_PLATFORM
  }

  OPTIONS = {
    headers:  {},
    nonblock: false,
  }

  class AuthenticationError < RuntimeError
  end

  class << self
    attr_accessor :last_response_body
    attr_accessor :log
  end

  def self.debug(*args, &block)
    @log && @log.puts(*args, &block)
  end

  def self.request(options)
    Dawn.authenticate unless @connection
    response = @connection.request(options)
    self.last_response_body = response.body
    response
  rescue Excon::Errors::HTTPStatusError => ex
    self.last_response_body = ex.response.body
    debug Time.now.strftime("%D %T")
    debug options.inspect
    debug ex.response.body
    debug "\n"
    raise ex
  end

  def self.authenticate(options={})
    options = OPTIONS.merge(host: dawn_api_host, scheme: dawn_scheme).merge(options)
    options[:headers] = options[:headers].merge(HEADERS)
    @api_key = options.delete(:api_key) || ENV['DAWN_API_KEY']

    if !@api_key
      hostname = options[:host]
      url = "#{options[:scheme]}://#{hostname}"

      if options.key?(:username) && options.key?(:password)
        username = options.delete(:username)
        password = options.delete(:password)

        @connection = Excon.new url, headers: HEADERS

        @api_key = User.login(username: username, password: password)['api_key']

        netrc = Netrc.read
        netrc[hostname] = username, @api_key
        netrc.save
      else
        netrc = Netrc.read
        username, api_key = netrc[hostname]
        if api_key
          @api_key = api_key
        else
          raise AuthenticationError, "api_key was not found, try dawn login to reset your .netrc"
          # "please provide a DAWN_API_KEY, username and password, or update your .netrc with the dawn details (use dawn login)"
        end
      end
    end
    @headers = HEADERS.merge(
      'Authorization' => "Basic #{::Base64.strict_encode64("#{username}:#{@api_key}")}"
    )
    @connection = Excon.new "#{options[:scheme]}://#{options[:host]}", headers: @headers
  end

end
