require 'rails_helper'

describe "As a user on the home page" do
  it "I can link to my representative's show page and see their contact info" do
    VCR.use_cassette("find_co_1_member_show_page") do
      representative = Representative.new(1)

      visit representative_path(representative.district)

      expect(page).to have_content(representative.name)
      expect(page).to have_content(representative.party)
      expect(page).to have_content(representative.facebook)
      expect(page).to have_content(representative.twitter)
    end
  end
  it 'I can see their website and image' do
    VCR.use_cassette("find_co_1_member_image_and_website") do
      representative = Representative.new(1)

      visit representative_path(representative.district)

      expect(page).to have_link(representative.website)
      expect(page).to have_xpath("//img[contains(@src,'#{representative.bioguide_id}.jpg')]")
    end
  end
end
