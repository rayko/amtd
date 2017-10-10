module AMTD
  class Configuration
    attr_accessor :source, :base_path, :request_timeout, :user, :password

    def initialize
      @base_path = 'https://apis.tdameritrade.com/apps'
      @request_timeout = 60
    end
  end
end
