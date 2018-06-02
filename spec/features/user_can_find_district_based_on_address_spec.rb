require 'rails_helper'

describe 'As a user on the root page' do
  it 'I can enter my address and find my congressional district' do
    VCR.use_cassette('search by address') do
      Representative.create(name: 'Mike Dao', district: 7)
      visit '/'

      fill_in :street, with: '1271 S Marshall St'
      fill_in :city, with: 'Lakewood'
      fill_in :state, with: 'CO'
      fill_in :postal_code, with: '80232'
      click_on 'Submit'

      expect(current_path).to eq '/representatives/7'
    end
  end
end
