module AMTD
  module Endpoints

    class Logout < BaseEndpoint
      attr_reader :adapter, :response

      def initialize adapter
        @adapter = adapter
        validate_params!
      end
      
      def execute!
        result = @adapter.post :url => url, :headers => headers, :body => payload
        handle_response(result)
      end

      private
      def handle_response data
        XMLParser.new(data).to_h
      end

      def validate_params!
        raise 'MissingSource' if AMTD.config.source.nil? || AMTD.config.source == ''
      end
      
      def endpoint_path
        '/100/LogOut'
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
