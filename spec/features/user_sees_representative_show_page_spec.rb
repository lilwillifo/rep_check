require 'rails_helper'

describe "As a user on the home page" do
  it "I can link to my representative's show page and see their contact info" do
    representative = Representative.new(1)

    visit representative_path(representative)

    expect(page).to have_content(representative.name)
    expect(page).to have_content(representative.party)
    expect(page).to have_content(representative.facebook)
    expect(page).to have_content(representative.twitter)
    expect(page).to have_content(representative.email)
    expect(page).to have_content(representative.website)
    expect(page).to have_xpath("//img[contains(@src,'#{representative.district}.jpg')]")
  end
end
