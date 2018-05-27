class PropublicaService

  def initialize(state, district=0)
    @state = state
    @district = district
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def find_house_member
    get_url("/congress/v1/members/house/#{state}/#{district}/current.json")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.find_house_member(state, district)
    new(state, district).find_house_member
  end

  private
  attr_reader :state, :district
end
