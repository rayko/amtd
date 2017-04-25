module AMTD
  module Errors
    module Endpoint
      class MissingParameter < ArgumentError
        def initialize param_key
          @param = param_key
        end

        def message
          "Required parameter '#{@param}' is missing"
        end

        def to_s
          message
        end
      end
    end

    module Adapter
      class RequestError < StandardError
        def initialize url, method, status
          @message = method
          @method = url
          @status = status
        end

        def message
          "#{@method} Request to #{@url} failed with status #{@status}"
        end

        def to_s
          message
        end
      end
    end

    module StreamerInfo
      class InvalidSession < StandardError; end

      class NotAllowed < StandardError
        def message
          "User is not allowed to access Streamer"
        end

        def to_s
          message
        end
      end
    end

    module KeepAlive
      class InvalidSession < StandardError; end
    end

    module Login
      class LoginFailed < StandardError
        def message
          "Params in URL string or using a GET request"
        end

        def to_s
          message
        end
      end

      class Unauthorized < StandardError
        def message
          "Unable to authorize access"
        end

        def to_s
          message
        end
      end
    end

  end
end
