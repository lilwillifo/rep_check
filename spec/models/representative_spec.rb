require 'rails_helper'

describe Representative, type: :model do
  it 'exists' do
    representative = Representative.new(1)
    expect(representative).to be_a Representative
  end
  it 'has valid attributes' do
    VCR.use_cassette("find_co_1_member_attributes") do
      representative = Representative.new(1)
      expect(representative.name).to be_a String
      expect(representative.party).to be_a String
      expect(representative.facebook).to be_a String
      expect(representative.twitter).to be_a String
      expect(representative.website).to be_a String
      expect(representative.bioguide_id).to be_a String
    end
  end
  it 'has valid for another district' do
    VCR.use_cassette("find_co_3_member_attributes") do
      representative = Representative.new(3)
      expect(representative.name).to be_a String
      expect(representative.party).to be_a String
      expect(representative.facebook).to be_a String
      expect(representative.twitter).to be_a String
      expect(representative.website).to be_a String
      expect(representative.bioguide_id).to be_a String
    end
  end
  context 'instance methods' do
    # it '.vote(bill_id) returns if the rep voted with majority rep or dem' do
    #   VCR.use_cassette("find_bill_votes") do
    #     representative = Representative.new(1)
    #     bill = Bill.create(bill_id: "hres70-115",
    #                        roll_call: 69,
    #                        chamber: "House",
    #                        year: 2017,
    #                        month: 1,
    #                        congress: 115,
    #                        name: "Providing for consideration of the joint resolution...",
    #                        democratic_majority_position: "No",
    #                        republican_majority_position: "Yes"
    #                      )
    #     expect(representative.vote(bill.roll_call)).to eq 'Dem'
    #   end
      it '.party_percent returns % of votes with their party' do
        VCR.use_cassette("find_bill_votes_by_party") do
            representative = Representative.new(1)
            bill_1 = Bill.create(bill_id: "hres70-115",
                               roll_call: 69,
                               chamber: "House",
                               year: 2017,
                               month: 1,
                               congress: 115,
                               name: "Providing for consideration of the joint resolution...",
                               democratic_majority_position: "No",
                               republican_majority_position: "Yes"
                             )
            bill_2 = Bill.create(bill_id: "hres71-115",
                                  roll_call: 70,
                                  chamber: "House",
                                  year: 2017,
                                  month: 1,
                                  congress: 115,
                                  name: "Another thing",
                                  democratic_majority_position: "No",
                                  republican_majority_position: "Yes"
                                )

            RepVotes.create(bill_id: bill_1.id, rep_name: representative.name, vote_with: 'Dem')
            RepVotes.create(bill_id: bill_2.id, rep_name: representative.name, vote_with: 'Rep')

            expect(representative.party_percent).to eq 50
      end
    end
  end
end
