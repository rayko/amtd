module AMTD
  class Client
    attr_reader :adapter, :user, :source, :session

    def initialize options={}
      @user = options.delete(:user) || AMTD.config.user
      @source = options.delete(:source) || AMTD.config.source
      @password = options.delete(:password) || AMTD.config.password
      @adapter = Adapter.new
    end

    def login
      validate_options!
      request = Endpoints::Login.new @adapter, {:userid => @user, :password => @password, :source => @source}
      request.execute!
    end

    def logout
      request = Endpoints::Logout.new @adapter, {:source => @source}
      @session = nil
      request.execute!
    end

    def keep_alive
      request = Endpoints::KeepAlive.new @adapter, {:source => @source}
      request.execute!
    end

    def streamer_info account_id=nil
      request = Endpoints::StreamerInfo.new @adapter, {:account_id => account_id, :source => @source}
      request.execute!
    end

    # Queries the AMTD price history endpoint to fetch prices. Does not require login, but 
    # if done, a session key will be set and passed to price history. Param validation is
    # on the endpoint class. The avaliable params are as follow:
    # - :request_value (R) -> the ticker simbol or symbols.
    # - :interval_type (R) -> :minute, :daily, :weekly or :montly. AMTD::Endpoints::PriceHistory::INTERVAL_TYPES.
    # - :interval_duration (R) -> an Int for the duration. AMTD::Endpoints::PriceHistory::INTERVAL_DURATIONS
    # for posible values.
    # - :period_type -> A timeframe to query, can be :day, :month, :year or :ytd. This would replace 
    # +start_date+ and +end_date+.
    # - :period -> An Int that describes how big is the timeframe defined by +:period_type+.
    # - :start_date -> A specific Date object for the start of the timeframe.
    # - :end_date -> A specific Date object fo the end of the timeframe.
    # - :extended -> Whether to include extended hours or not in the response.
    #
    # (R) params are required, the rest are optional. Note that you can only choose either +:period_type+ and
    # +:period+, or +:start_date+ and +:end_date+. Both describe the timeframe to query. Refer to
    # AMTD official documentation for more info about valid values. Some parameters are dependent on what
    # values can take depending on other values. While the optional parameters can be ommited, you need
    # to specify one set at least, either +start_date+ and +end_date+ or +period_type+ and +period+.
    def price_history params
      raise ArgumentError, 'Missing source' if source.nil? || source == ''
      if session
        request = Endpoints::PriceHistory.new @adapter, params.merge({:session => session, :source => source})
      else
        request = Endpoints::PriceHistory.new @adapter, params.merge({:source => source})
      end
      request.execute!
    end

    private
    def validate_options!
      raise ArgumentError, "Missing user" if @user.nil? || @user == ''
      raise ArgumentError, "Missing source" if @source.nil? || @source == ''
      raise ArgumentError, "Missing password" if @password.nil? || @password == ''
    end
  end
end
