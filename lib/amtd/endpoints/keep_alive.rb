module AMTD
  module Endpoints

    class KeepAlive < BaseEndpoint
      attr_reader :adapter, :response

      def initialize adapter, params
        @adapter = adapter
        validate_params!(params)
      end
      
      def execute!
        result = @adapter.post :url => url, :headers => default_headers, :body => endpoint_parameters
        handle_response(result)
      end

      private
      def required_params
        [:source]
      end

      def handle_response data
        @response = {:result => data}
        raise Errors::KeepAlive::InvalidSession if @response[:result] == 'InvalidSession'
        return @response
      end

      def endpoint_path
        '/KeepAlive'
      end
    end

  end
end
