class Representative
  attr_reader :district, :name, :party, :facebook, :twitter, :email, :website
  def initialize(district)
    @district = district
  end

  def name
    service.house_member[:name]
  end

  def party
    if service.house_member[:party] == 'D'
      'Democrat'
    elsif service.house_member[:party] == 'R'
      'Republican'
    else
      'Other'
    end
  end

  def facebook
    service.house_member[:facebook_account]
  end

  def twitter
    service.house_member[:twitter_id]
  end

  def website
    service.house_member_details[:url]
  end

  def bioguide_id
    service.house_member_details[:member_id]
  end

  def vote(rep_id, roll_call)
    RepBillSearch.new(rep_id, roll_call)
  end

  private

    attr_reader :state

    def service
      @service ||= PropublicaService.new('CO', @district)
    end
end
