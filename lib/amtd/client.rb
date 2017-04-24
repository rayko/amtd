module AMTD
  class Client
    attr_reader :adapter

    def initialize
      @adapter = Adapter.new
    end

    def login user_id, password
      request = Endpoints::Login.new @adapter, {:user_id => user_id, :password => password}
      request.execute!
    end

    def logout
      request = Endpoints::Logout.new @adapter
      request.execute!
    end

    def keep_alive
      request = Endpoints::KeepAlive.new @adapter
      request.execute!
    end
  end
end
