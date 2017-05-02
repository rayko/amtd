module AMTD
  class Client
    attr_reader :adapter

    def initialize
      @adapter = Adapter.new
    end

    def login user_id, password
      params = sanitize_params({:userid => user_id, :password => password}.merge(source_param))
      request = Endpoints::Login.new @adapter, params
      request.execute!
    end

    def logout
      request = Endpoints::Logout.new @adapter, sanitize_params(source_param)
      request.execute!
    end

    def keep_alive
      request = Endpoints::KeepAlive.new @adapter, sanitize_params(source_param)
      request.execute!
    end

    def streamer_info account_id=nil
      params = sanitize_params({:account_id => account_id}.merge(source_param))
      request = Endpoints::StreamerInfo.new @adapter, params
      request.execute!
    end

    private
    def sanitize_params params
      sanitized = params.delete_if{|k,v| v.nil? || v == ''}

      return sanitized
    end

    def source_param
      {:source => AMTD.config.source}
    end
  end
end
