module AMTD
  module Endpoints
    class BaseEndpoint
      private
      def base_path
        AMTD.config.base_path
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
