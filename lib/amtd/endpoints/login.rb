module AMTD
  module Endpoints

    class Login < BaseEndpoint
      attr_reader :adapter, :response

      def initialize adapter, params
        @adapter = adapter
        @user_id = params.delete(:user_id)
        @password = params.delete(:password)
        validate_params!
      end
      
      def execute!
        result = @adapter.post :url => url, :headers => headers, :body => payload
        handle_response(result)
      end

      private
      def handle_response data
        @response = XMLParser.new(data).to_h
        raise Errors::Login::LoginFailed if @response[:result] == 'FAIL' && @response[:error] == 'Login Failed'
        raise Errors::Login::Unauthorized if @response[:result] == 'FAIL'
        return @response
      end

      def validate_params!
        raise 'MissingUserId' if @user_id.nil? || @user_id == ''
        raise 'MissingPassword' if @password.nil? || @password == ''
        raise 'MissingSource' if AMTD.config.source.nil? || AMTD.config.source == ''
      end
      
      def endpoint_path
        '/300/LogIn'
      end

      def url
        base_path + endpoint_path
      end

      def headers
        default_headers.merge({'Content-Type' => 'application/x-www-form-urlencoded'})
      end

      def payload
        {:userid => @user_id, :password => @passowrd, :source => AMTD.config.source}
      end
    end

  end
end
