require 'rails_helper'

describe Bill do
  it 'has valid attributes' do
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
    expect(bill.bill_id).to eq "hres70-115"
    expect(bill.roll_call).to eq 69
    expect(bill.chamber).to eq 'House'
    expect(bill.year).to eq 2017
    expect(bill.month).to eq 1
    expect(bill.congress).to eq 115
    expect(bill.name).to eq "Providing for consideration of the joint resolution..."
    expect(bill.democratic_majority_position).to eq 'No'
    expect(bill.republican_majority_position).to eq 'Yes'
  end
end
