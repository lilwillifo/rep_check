class PropublicaService

  def initialize(state='CO', district=0)
    @state = state
    @district = district
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_api_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def bills
    i=1
    while i<10
      Bill.new(get_url("/congress/v1/house/votes/2017/0#{i}.json"))
      Bill.new(get_url("/congress/v1/house/votes/2018/0#{i}.json"))
    end
    Bill.new(get_url("/congress/v1/house/votes/2017/10.json"))
    Bill.new(get_url("/congress/v1/house/votes/2017/11.json"))
    Bill.new(get_url("/congress/v1/house/votes/2017/12.json"))
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
