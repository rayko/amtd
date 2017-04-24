module AMTD
  module Endpoints

    class Login
      VERSION = '2.91'

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
        XMLParser.new(data).to_h
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
        AMTD.config.base_path + endpoint_path
      end

      def headers
        {
          'Content-Type' => 'application/x-www-form-urlencoded'
        }
      end

      def payload
        {:userid => @user_id, :password => @passowrd, :source => AMTD.config.source, :version => VERSION}
      end
    end

  end
end
