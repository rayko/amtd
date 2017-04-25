module AMTD
  module Endpoints
    class BaseEndpoint
      attr_reader :adapter, :response

      private
      def required_params
        []
      end

      def optional_params
        []
      end

      def endpoint_parameters
        required_params + optional_params
      end

      def validate_params! params
        valid_params = {}
        required_params.each do |key|
          raise Errors::Endpoint::MissingParameter.new(key) if params[key] == '' || params[key].nil?
          valid_params[key] = params[key]
        end
        optional_params.each{|k,v| valid_params[k] = v}
        return valid_params
      end

      def base_path
        AMTD.config.base_path
      end

      def endpoint_path
        ''
      end

      def url
        base_path + endpoint_path
      end

      def default_headers
        {}
      end

      def version
        '2.91'
      end
    end
  end
end
