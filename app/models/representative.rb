class Representative < ApplicationRecord
  enum party: ["Democrat", "Republican", "Other"]

  def website
    Rails.cache.fetch("website-#{district}", expires_in: 7.days) do
      service.house_member_details[:url]
    end
  end

  def bioguide_id
    Rails.cache.fetch("memberid-#{district}", expires_in: 7.days) do
      service.house_member_details[:member_id]
    end
  end

  def party_percent
    with_party = votes.length.to_f - votes_against_party.length
    (with_party / votes.length.to_f * 100).round(2)
  end

  def anti_party_vote_categories
    Rails.cache.fetch("anti-party-#{district}", expires_in: 1.day) do
      anti_party_vote_categories = {}
      vote_against_categories.map do |category|
        anti_party_vote_categories[category] = vote_against_categories.count(category)
      end
      anti_party_vote_categories.sort_by{|category, count| count}.reverse.to_h
    end
  end

  private

    def service
      @service ||= PropublicaService.new('CO', district)
    end

    def votes
      RepVotes.where(rep_name: "#{name}")
    end

    def votes_against_party
      votes.select do |vote|
        !party.include?(vote.vote_with)
      end
    end

    def bill_ids_against
      votes_against_party.map(&:bill_id)
    end

    def vote_against_categories
      bill_ids_against.map do |id|
        Bill.find(id).category
      end
    end

end
