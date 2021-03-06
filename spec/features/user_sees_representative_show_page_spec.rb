require 'rails_helper'

describe "As a user" do
  let(:representative) {create(:representative)}
  let(:category) {Category.create(name: 'Government Operations and Politics')}

  it "I can link to my representative's show page and see their contact info" do
    VCR.use_cassette("find_co_rep_show_page") do
      visit representative_path(representative.district)

      expect(page).to have_content(representative.name)
      expect(page).to have_content(representative.party)
      expect(page).to have_link("Facebook")
    end
  end
  it 'I can see their website and image' do
    VCR.use_cassette("find_co_1_member_image_and_website") do
      visit representative_path(representative.district)

      expect(page).to have_selector(:css, "a[href='#{representative.website}']")
      expect(page).to have_xpath("//img[contains(@src,'#{representative.bioguide_id}.jpg')]")
    end
  end
  it 'I can see their votes and I can sort by category and month' do
    VCR.use_cassette("find_all_bills") do
      bill = create(:bill, category_id: category.id)
      category2 = Category.create(id: 2, name: 'Another Category')
      bill.rep_votes.create(rep_name: representative.name, vote_with: 'Democrat')

      visit representative_path(representative.district)

      within('#votes') do
        expect(page).to have_content('2017')

        click_on category.name

        expect(page).to have_content('Providing for consideration of ')
      end
      click_on category2.name
      expect(current_url).to include '/representatives/1?category=Another%20Category'
      expect(page).to_not have_content('Providing for consideration of the joint resolution')
      click_on 'February'
      expect(current_url).to include '/representatives/1?month=2'
      expect(page).to_not have_content('Providing for consideration of the joint resolution')

    end
  end
  it 'I can see if the rep voted with or against their party' do
    VCR.use_cassette("find_how_rep_voted") do
      bill = create(:bill, category_id: category.id)

      bill.rep_votes.create(rep_name: representative.name, vote_with: 'Democrat')
      visit representative_path(representative.district)

      within('#hres70-115') do
        expect(page).to have_css(".dem")
      end

      expect(page).to have_content('100.0%')
    end
  end
  it 'I can see a summary of what category they strayed from their party' do
    VCR.use_cassette('bills_summary') do
      bill = create(:bill, category_id: category.id)

      bill.rep_votes.create(rep_name: representative.name, vote_with: 'Republican')
      visit representative_path(representative.district)

      within('#summary') do
        expect(page).to have_content('Broke Party Lines on These Issues:')
        representative.anti_party_vote_categories.each do |category, count|
          expect(page).to have_content(category.name)
          expect(page).to have_content("(#{count} Bill)")
        end
      end
    end
  end
end

describe 'As a user' do
  it 'I cant visit a page for a district that doesnt exist' do
    visit '/representatives/10'

    expect(current_path).to eq '/'
    expect(page).to have_content "Sorry! That link doesn't exist."
  end
end
