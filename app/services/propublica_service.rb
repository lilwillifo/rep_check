class PropublicaService
  def initialize(state, district)
    @state = state
    @district = district
  end

  def name
    raw_search[:results][:name]
  end

    attr_reader :state, :district

    def response
      @response ||= conn.get do |req|
        req.headers['X-API-Key'] = ENV['propublica_api_key']
      end
    end

    def raw_search
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: "https://api.propublica.org/congress/v1/members/house/#{state}/#{district}/current.json")
    end
end
