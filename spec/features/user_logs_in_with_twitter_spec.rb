require 'rails_helper'
describe 'As a user' do
  it 'I can log in with twitter' do
    stub_omniauth

    visit "/"
    click_link "Sign in with Twitter"
    expect(current_path).to eq('/')
    expect(page).to have_content('worace')
    expect(page).to have_link('Logout')
  end
  context 'as a signed in user ' do
    let(:user) { create(:user) }
    it 'I can logout' do
      visit '/'
      click_link "Sign in with Twitter"
      click_link 'Logout'

      expect(page).to have_content('Sign in with Twitter')
    end
  end
end

def stub_omniauth
  # first, set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true
  # then, provide a set of fake oauth data that
  # omniauth will use when a user tries to authenticate:
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    extra: {
      raw_info: {
        user_id: "1234",
        name: "Horace",
        screen_name: "worace"
      }
    },
    credentials: {
      token: "pizza",
      secret: "secretpizza"
    }
  })
end
