require 'rails_helper'

describe 'As a user on the root page' do
  it 'I can enter my address and find my congressional district' do
    VCR.use_cassette('search by address') do
      visit '/'

      fill_in :street, with: '1271 S Marshall St'
      fill_in :city, with: 'Lakewood'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80232'
      click 'Submit'

      expect(current_path).to eq '/representatives/7'
    end
  end
end
