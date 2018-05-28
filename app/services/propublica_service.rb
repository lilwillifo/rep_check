class PropublicaService

  def initialize(state, district=0)
    @state = state
    @district = district
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_api_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def name
    find_house_member[:name]
  end

  def party
    find_house_member[:party]
  end

  def facebook
    find_house_member[:facebook_account]
  end

  def twitter
    find_house_member[:twitter_id]
  end

  def website
    house_member_details[:url]
  end

  def bioguide_id
    house_member_details[:member_id]
  end

  def house_member_details
    get_url(find_house_member[:api_uri].split('org')[1]).first
  end

  def find_house_member
    get_url("/congress/v1/members/house/#{state}/#{district}/current.json").first
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
