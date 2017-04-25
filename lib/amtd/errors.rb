module AMTD
  module Errors
    module Adapter
      class RequestError < StandardError
        def initialize url, method, status
          @message = "#{method} Request to #{url} failed with status #{status}"
        end
      end
    end

    module KeepAlive
      class InvalidSession < StandardError
      end
    end

    module Login
      class LoginFailed < StandardError
        def initialize
          @message = "Params in url or using a GET request"
        end
      end

      class Unauthorized < StandardError
        def initialize
          @message = "Unable to authorize access"
        end
      end
    end
  end
end
