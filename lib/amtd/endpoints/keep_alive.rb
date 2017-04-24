module AMTD
  module Endpoints

    class KeepAlive < BaseEndpoint
      attr_reader :adapter, :response

      def initialize adapter
        @adapter = adapter
        validate_params!
      end
      
      def execute!
        result = @adapter.post :url => url, :headers => default_headers, :body => payload
        handle_response(result)
      end

      private
      def handle_response data
        {:result => data}
      end

      def validate_params!
        raise 'MissingSource' if AMTD.config.source.nil? || AMTD.config.source == ''
      end
      
      def endpoint_path
        '/KeepAlive'
      end

      def url
        base_path + endpoint_path
      end

      def payload
        {:source => AMTD.config.source}
      end
    end

  end
end
