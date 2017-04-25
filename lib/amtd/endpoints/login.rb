module AMTD
  module Endpoints

    class Login < BaseEndpoint
      attr_reader :adapter, :response, :request_parameters

      def initialize adapter, params
        @adapter = adapter
        @request_parameters = validate_params!(params)
      end
      
      def execute!
        result = @adapter.post :url => url, :headers => headers, :body => @request_parameters.merge({:version => version})
        handle_response(result)
      end

      private
      def required_params
        [:source, :user_id, :password]
      end

      def handle_response data
        @response = XMLParser.new(data).to_h
        raise Errors::Login::LoginFailed if error? && @response[:error] == 'Login Failed'
        raise Errors::Login::Unauthorized if error?
        return @response
      end

      def error?
        @response[:result] == 'FAIL'
      end

      def endpoint_path
        '/300/LogIn'
      end

      def headers
        default_headers.merge({'Content-Type' => 'application/x-www-form-urlencoded'})
      end
    end

  end
end
