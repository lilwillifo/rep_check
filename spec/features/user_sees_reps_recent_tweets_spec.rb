require 'rails_helper'

describe "As a user" do
  let(:representative) {Representative.create(district: 1, name: 'Dianna DeGette')}
  let(:category) {Category.create(name: 'Government Operations and Politics')}

  it "I can see my representative's 5 most recent tweets on their show page" do
    VCR.use_cassette("see_recent_tweets") do
      visit representative_path(representative.district)

      representative.recent_tweets.each do |tweet|
        expect(page).to have_content(tweet)
      end
    end
  end
end
