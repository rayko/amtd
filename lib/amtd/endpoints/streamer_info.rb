module AMTD
  module Endpoints

    class StreamerInfo < BaseEndpoint
      def initialize adapter, params
        @adapter = adapter
        options = validate_params!(params)
        @account_id = params[:account_id]
      end

      def execute!
        result = @adapter.get :url => url, :headers => default_headers, :query => endpoint_parameters
        handle_response(result)
      end

      private
      def handle_response data
        @response = XMLParser.new(data).to_h
        raise Errors::StreamerInfo::NotAllowed if error? && @response[:error] == 'NS'
        raise Errors::StreamerInfo::InvalidSession if error? && @response[:error] == 'Invalid Session.'
        return @response
      end

      def error?
        @response[:result] == 'FAIL'
      end

      def endpoint_path
        '/100/StreamerInfo'
      end

      def required_params
        [:source]
      end

      def optional_params
        [:account_id]
      end
    end

  end
end
