class Representative
  attr_reader :district, :name, :party, :facebook, :twitter, :email, :website
  def initialize(district)
    @district = district
  end

  def name
    service.name
  end
  def party
    service.party
  end
  def facebook
    service.facebook
  end
  def twitter
    service.twitter
  end
  def email
    service.email
  end
  def website
    service.website
  end

  def image
    service.image
  end

    attr_reader :state

    def service
      @service ||= PropublicaService.new('CO', @district)
    end
end
