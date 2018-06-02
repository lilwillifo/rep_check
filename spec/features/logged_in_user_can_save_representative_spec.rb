require 'rails_helper'

describe 'As a logged in user' do
  let(:user) { create(:user) }
  before {allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)}
  it 'I can save reps' do
    visit '/representatives/1'

    click_link 'Save to Favorites'

    expect(current_path).to eq('/representatives/1')
    expect(page).to have_css('.fa-heart')
  end
  it 'I can tweet at my representative' do

  end
  it 'I can see my favorites dashboard' do
    
  end
end
