require 'rails_helper'

describe 'As a user' do
  context 'when I visit the house index' do
    it  'I see all current members of the House of Reps' do
      reps = create_list(:representative, 7)
      visit '/'
      click_link 'House'

      expect(current_path).to eq('/house')
      expect(page).to have_content('Colorado Representatives')

      reps.each do |rep|
        expect(page).to have_link(rep.name)
        expect(page).to have_content(rep.party)
      end

    end
  end
end
