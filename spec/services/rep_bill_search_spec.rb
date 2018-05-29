require 'rails_helper'

describe RepBillSearch do
  it 'exists' do
    search = RepBillSearch.new('abc', '123')
    expect(search).to be_a RepBillSearch
  end
  it 'has valid attributes' do
    search = RepBillSearch.new('abc', '123')
    expect(search.rep_id).to eq 'abc'
    expect(search.roll_call).to eq '123'
  end
end
