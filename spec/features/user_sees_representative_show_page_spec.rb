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

      expect(page).to have_selector(:css, "a[href='#{representative.website}']")
      expect(page).to have_xpath("//img[contains(@src,'#{representative.bioguide_id}.jpg')]")
    end
  end
  xit 'I can see their votes and I can sort by category and year' do
    VCR.use_cassette("find_all_bills") do
      representative = Representative.new(1)

      visit representative_path(representative.district)

      within('#votes') do
        expect(page).to have_content('2017')

        click_on 'Guns'

        expect(page).to have_content('H.R. 38: Concealed Carry Reciprocity Act of 2017')
        expect(page).to_not have_content('H.R. 354: Defund Planned Parenthood Act of 2017')
      end
    end
  end
  it 'I can see if the rep voted with or against their party' do
    VCR.use_cassette("find_how rep voted") do
      representative = Representative.new(1)
      bill = Bill.create(bill_id: "hres70-115",
                         roll_call: 69,
                         chamber: "House",
                         year: 2017,
                         month: 1,
                         congress: 115,
                         name: "Providing for consideration of the joint resolution...",
                         democratic_majority_position: "No",
                         republican_majority_position: "Yes"
                       )

      visit representative_path(representative.district)

      within('#hres70-115') do
        expect(page).to have_css(".dem")
      end
    end
  end
end
