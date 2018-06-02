require 'rails_helper'

describe 'As a logged in user' do
  let(:user) { create(:user) }
  it 'I can favorite and unfavorite reps' do
    VCR.use_cassette('logged_in_user') do
      Representative.create(district: 1, name: 'Dianna DeGette')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/representatives/1'

      click_link 'Save to Favorites'

      expect(current_path).to eq('/representatives/1')
      expect(page).to have_content('Added to your favorite list!')
      expect(page).to have_css('.fa-heart')
      find(:xpath, ".//a[i[contains(@class, 'fas fa-heart')]]").click
      expect(current_path).to eq('/')
      expect(page).to have_content('Removed from your favorite list!')
    end
  end
  xit 'I can tweet at my representative' do

  end
  xit 'I can see my favorites dashboard' do

  end
end
