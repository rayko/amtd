require "amtd/version"
require "amtd/configuration"
require "amtd/adapter"
require "amtd/client"
require "amtd/xml_parser"
require "amtd/errors"

require "amtd/endpoints/base_endpoint"
require "amtd/endpoints/login"
require "amtd/endpoints/logout"
require "amtd/endpoints/keep_alive"

require "httparty"
require "nokogiri"

module AMTD
  class << self
    attr_accessor :configuration
    alias config configuration

    def configure
      yield(configuration)
      self.configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
