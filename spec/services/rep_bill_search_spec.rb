require 'rails_helper'

describe RepBillSearch do
  it 'exists' do
    search = RepBillSearch.new('abc', '123')
    expect(search).to be_a RepBillSearch
  end
  it 'has valid attributes' do
    search = RepBillSearch.new('Margaret', '123')
    expect(search.name).to eq 'Margaret'
    expect(search.roll_call).to eq '123'
  end
  context 'instance methods' do
    it '.vote' do
      VCR.use_cassette("find_a_specific_vote") do
        rep = Representative.new(1)
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
        search = RepBillSearch.new(rep.name, bill.roll_call)
        expect(search.vote).to eq('No')
      end
    end
  end
end
