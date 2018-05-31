class Representative < ApplicationRecord
  # attr_reader :district, :name, :party, :facebook, :twitter, :website
  enum vote_with: ["Dem", "Rep", "Other"]

  # def initialize(district)
  #   @district = district
  # end


  def website
    service.house_member_details[:url]
  end

  def bioguide_id
    service.house_member_details[:member_id]
  end

  def party_percent
    with_party = votes.length.to_f - votes_against_party.length
    (with_party / votes.length.to_f * 100).round(2)
  end

  def bills_against_categories
    ids = votes_against_party.map(&:bill_id)
    ids.map do |id|
      Bill.find(id).category
    end.uniq
  end

  private


    # def name
    #   service.house_member[:name]
    # end
    #
    # def party
    #   if service.house_member[:party] == 'D'
    #     'Democrat'
    #   elsif service.house_member[:party] == 'R'
    #     'Republican'
    #   else
    #     'Other'
    #   end
    # end
    #
    # def facebook
    #   service.house_member[:facebook_account]
    # end
    #
    # def twitter
    #   service.house_member[:twitter_id]
    # end

    attr_reader :state

    def service
      @service ||= PropublicaService.new('CO', @district)
    end

    def votes
      RepVotes.where(rep_name: "#{name}")
    end

    def votes_against_party
      votes.select do |vote|
        !party.include?(vote.vote_with)
      end
    end
end
