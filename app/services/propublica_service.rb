class PropublicaService

  def initialize(state='CO', district=0)
    @state = state
    @district = district
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_api_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def house_member_details
    get_url(house_member[:api_uri].split('org')[1]).first
  end

  def house_member
    get_url("/congress/v1/members/house/#{state}/#{district}/current.json").first
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.house_member(state, district)
    new(state, district).house_member
  end

  private
  attr_reader :state, :district
end
