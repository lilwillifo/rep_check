require 'rails_helper'

describe RepVotes, type: :model do
  it 'exists' do
    VCR.use_cassette("repvotes") do
      representative = create(:representative)
      category = create(:category)
      bill = create(:bill, category_id: category.id)

      repvote = RepVotes.create(rep_name: representative.name, bill_id: bill.id)
      expect(repvote).to be_a RepVotes
    end
  end
end
