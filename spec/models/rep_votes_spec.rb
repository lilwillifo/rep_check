require 'rails_helper'

describe RepVotes, type: :model do
  it 'exists' do
    VCR.use_cassette("repvotes") do
      representative = Representative.create(district: 1)
      bill = Bill.create(bill_id: "hres70-115",
                         roll_call: 69,
                         chamber: "House",
                         year: 2017,
                         month: 1,
                         congress: 115,
                         name: "Providing for consideration of the joint resolution...",
                         democratic_majority_position: "No",
                         republican_majority_position: "Yes"
                       )
      repvote = RepVotes.create(rep_name: representative.name, bill_id: bill.id)
      expect(repvote).to be_a RepVotes
    end
  end
end
