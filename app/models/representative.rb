class Representative
  attr_reader :district, :name, :party, :facebook, :twitter, :email, :website
  def initialize(district)
    @district = district
  end

  def name
    service.name
  end
  def party
  end
  def facebook
  end
  def twitter
  end
  def email
  end
  def website
  end

    attr_reader :state

    def service
      @service ||= PropublicaService.new('CO', @district)
    end
end
