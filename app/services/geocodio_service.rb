class GeocodioService

  def initialize(address)
    @address = address
  end

  def district
    get_url.first[:fields][:congressional_districts].first[:district_number]
  end

  private

  attr_reader :address
  def conn
    Faraday.new(url: "https://api.geocod.io/v1.3/geocode") do |faraday|
      faraday.params["api_key"] = ENV["geocodio_api_key"]
      faraday.adapter Faraday.default_adapter
    end
  end

    def get_url
      response = conn.get do |req|
        req.params['street'] = @address[:street]
        req.params['city'] = @address[:city]
        req.params['state'] = @address[:state]
        req.params['postal_code'] = @address[:postal_code]
        req.params['fields'] = 'cd'
      end
      JSON.parse(response.body, symbolize_names: true)[:results]
    end
end
