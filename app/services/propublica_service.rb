class PropublicaService
  def initialize(state)
    @state = state
  end

  def members
    raw_search[:results]
  end

  private
    attr_reader :state

    def response
      @response ||= conn.get do |req|
        req.headers['X-API-Key'] = ENV['propublica_api_key']
      end
    end

    def raw_search
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: "https://api.propublica.org/congress/v1/members/house/#{state}/current.json")
    end
end
