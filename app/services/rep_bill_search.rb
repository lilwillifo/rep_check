class RepBillSearch
  attr_reader :name, :roll_call
  def initialize(name, roll_call)
    @name = name
    @roll_call = roll_call
    @conn = Faraday.new(url: "https://api.propublica.org") do |faraday|
      faraday.headers["X-API-Key"] = ENV["propublica_api_key"]
      faraday.adapter  Faraday.default_adapter
    end
  end

  def vote
    response = get_url("/congress/v1/115/house/sessions/1/votes/#{@roll_call}.json")
    positions = response[:votes][:vote][:positions]
    raw_rep_position = positions.select {|member| member[:name] == @name}
    vote_position = raw_rep_position.first[:vote_position]
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
