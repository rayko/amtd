module AMTD
  module Endpoints

    class Logout < BaseEndpoint
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
      def handle_response data
        XMLParser.new(data).to_h
      end

      def endpoint_path
        '/100/LogOut'
      end
    end

  end
end
