require 'rails_helper'

describe 'As a logged in user' do
  let(:user) { create(:user) }
  it 'I can favorite and unfavorite reps' do
    VCR.use_cassette('logged_in_user') do
      rep = create(:representative)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/representatives/1'

      click_on("👀")

      expect(current_path).to eq("/representatives/#{rep.district}")
      expect(page).to have_content('Added to your watch list!')
      click_link('Unfollow')
      expect(current_path).to eq('/')
      expect(page).to have_content('Removed from your watch list.')
    end
  end
  it 'I can tweet at my representative' do
    VCR.use_cassette('logged_in_user') do
      rep = create(:representative)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/representatives/#{rep.district}"

      href = "https://twitter.com/intent/tweet?screen_name=#{rep.twitter}"
      expect(page).to have_selector "a[href='#{href}']", text: "Tweet Your Representative!"

    end
  end
  it 'I can see my favorites dashboard' do
    VCR.use_cassette('logged_in_user') do
      rep = create(:representative)
      Favorite.create(representative_id: rep.id, user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'

      click_link 'Watch List'
      expect(current_path).to eq('/favorites')
      expect(page).to have_link(rep.name)
      expect(page).to have_content(rep.party)
    end
  end
  it 'a non logged in user can not see favorites' do
    VCR.use_cassette('guest_user') do
      visit '/'

      expect(page).to_not have_link('My Favorites')

      visit '/favorites'
      expect(current_path).to eq('/')
    end
  end
end
