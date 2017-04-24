require "amtd/version"
require "amtd/configuration"
require "amtd/adapter"
require "amtd/client"
require "amtd/xml_parser"

require "amtd/endpoints/login"

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
