module AMTD
  class Adapter

    def get params
      url = params.delete(:url)
      response = HTTParty.get url, params.merge(default_params)
      handle_response(response)
    end

    def post params
      url = params.delete(:url)
      response = HTTParty.post url, params.merge(default_params)
      handle_response(response)
    end

    private
    def handle_response response
      raise Errors::Adapter::RequestError.new(response.code, response.request.http_method, response.code) unless response.code == 200
      return response.body
    end

    def default_params
      {:timeout => AMTD.config.request_timeout}
    end

  end
end
