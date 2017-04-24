require "amtd/version"
require "amtd/configuration"

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
