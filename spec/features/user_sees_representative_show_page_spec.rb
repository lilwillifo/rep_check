require 'rails_helper'

describe "As a user on the home page" do
  let(:representative) {Representative.new(1)}
  let(:bill) {Bill.create(bill_id: "hres70-115",
                     roll_call: 69,
                     chamber: "House",
                     year: 2017,
                     month: 1,
                     congress: 115,
                     name: "Providing for consideration of the joint resolution...",
                     democratic_majority_position: "No",
                     republican_majority_position: "Yes"
                   )
                    }
  it "I can link to my representative's show page and see their contact info" do
    VCR.use_cassette("find_co_rep_show_page") do
      visit representative_path(representative.district)

      expect(page).to have_content(representative.name)
      expect(page).to have_content(representative.party)
      expect(page).to have_content(representative.facebook)
      expect(page).to have_content(representative.twitter)
    end
  end
  it 'I can see their website and image' do
    VCR.use_cassette("find_co_1_member_image_and_website") do
      visit representative_path(representative.district)

      expect(page).to have_selector(:css, "a[href='#{representative.website}']")
      expect(page).to have_xpath("//img[contains(@src,'#{representative.bioguide_id}.jpg')]")
    end
  end
  it 'I can see their votes and I can sort by category and year' do
    VCR.use_cassette("find_all_bills") do
      category = Category.create(name: 'Government Operations and Politics')
      category.bills.create( bill_id: "hres70-115",
                             roll_call: 69,
                             chamber: "House",
                             year: 2017,
                             month: 1,
                             congress: 115,
                             name: "Providing for consideration of the joint resolution...",
                             democratic_majority_position: "No",
                             republican_majority_position: "Yes"
                            )
      category2 = Category.create(name: 'Another Category')
      visit representative_path(representative.district)

      within('#votes') do
        expect(page).to have_content('2017')

        click_on category.name

        expect(page).to have_content('Providing for consideration of the joint resolution')

        click_on category2.name

        expect(page).to_not have_content('Providing for consideration of the joint resolution')
      end
    end
  end
  it 'I can see if the rep voted with or against their party' do
    VCR.use_cassette("find_how_rep_voted") do
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
      bill.rep_votes.create(rep_name: representative.name, vote_with: 'Dem')
      visit representative_path(representative.district)

      within('#hres70-115') do
        expect(page).to have_css(".dem")
      end

      within('#summary') do
        expect(page).to have_content('100.0%')
      end
    end
  end
end
