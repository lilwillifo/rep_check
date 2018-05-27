require 'rails_helper'

describe "As a user on the home page" do
  it "I can link to my representative's show page and see their contact info" do
    representative = Representative.new(1)
    visit '/'
    click_on representative.district
    expect(current_path).to eq(representative_path(representative))

    expect(page).to have_content(representative.name)
    expect(page).to have_content(representative.party)
    expect(page).to have_content(representative.facebook)
    expect(page).to have_content(representative.twitter)
    expect(page).to have_content(representative.email)
    expect(page).to have_content(representative.website)
    expect(page).to have_xpath("//img[contains(@src,'#{representative.district}.jpg')]")
  end
end

And I should see a message "7 Results"
And I should see a list of 7 the members of the house for Colorado
And they should be ordered by seniority from most to least
And I should see a name, role, party, and district for each member
