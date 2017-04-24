module AMTD
  class Adapter

    def get params
      url = params.delete(:url)
      response = HTTParty.get params url, params.merge(default_params)
      handle_response(response)
    end

    def post params
      url = params.delete(:url)
      response = HTTParty.post url, params.merge(default_params)
      handle_response(response)
    end

    private
    def handle_response response
      return response.body if response.code == 200
      # TODO Better error
      raise 'AdapterError'
    end

    def default_params
      {:timeout => AMTD.config.request_timeout}
    end
  end
end
