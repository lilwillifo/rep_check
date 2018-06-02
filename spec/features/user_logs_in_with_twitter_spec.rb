require 'rails_helper'
describe 'As a user' do
  it 'I can log in with twitter' do
    Capybara.app = RepCheck::Application
    stub_omniauth

    visit "/"
    click_link "Sign in with Twitter"
    assert_equal "/", current_path
    assert page.has_content?("Horace")
    assert page.has_link?("Logout")
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
