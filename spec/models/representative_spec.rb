require 'rails_helper'

describe Representative, type: :model do
  it 'exists' do
    representative = Representative.create(district: 1)
    expect(representative).to be_a Representative
  end
  it 'has valid attributes' do
    VCR.use_cassette("find_co_1_member_attributes") do
      representative = Representative.create(district: 1, name: 'Margaret', party: 'Democrat', facebook: '', twitter: '')
      expect(representative.name).to be_a String
      expect(representative.party).to be_an String
      expect(representative.facebook).to be_a String
      expect(representative.twitter).to be_a String
      expect(representative.website).to be_a String
      expect(representative.bioguide_id).to be_a String
    end
  end
  it 'has valid for another district' do
    VCR.use_cassette("find_co_3_member_attributes") do
      representative = Representative.create(district: 3, name: 'Someone else', party: 'Republican', facebook: '', twitter: '')
      expect(representative.name).to be_a String
      expect(representative.party).to be_an String
      expect(representative.facebook).to be_a String
      expect(representative.twitter).to be_a String
      expect(representative.website).to be_a String
      expect(representative.bioguide_id).to be_a String
    end
  end
  context 'instance methods' do
      it '.party_percent returns % of votes with their party' do
        VCR.use_cassette("find_party_percent") do
          representative = Representative.create(district: 1, name: 'Dianna DeGette', party: 'Democrat', facebook: '', twitter: '')
            category = Category.create(name: 'Something')
            bill_1 = create(:bill, category_id: category.id)

            bill_2 = create(:bill, category_id: category.id)


            RepVotes.create(bill_id: bill_1.id, rep_name: representative.name, vote_with: 'Democrat')
            RepVotes.create(bill_id: bill_2.id, rep_name: representative.name, vote_with: 'Republican')

            expect(representative.party_percent).to eq 50
      end
    end
    it '.bills_against_categories returns all bills where the rep voted against party' do
      VCR.use_cassette("find_votes_against_party") do
        representative = Representative.create(district: 1, name: 'Dianna DeGette', party: 'Democrat', facebook: '', twitter: '')
          category = Category.create(name: 'Something')
          bill_1 = create(:bill, category_id: category.id)
          bill_2 = create(:bill, category_id: category.id)


          RepVotes.create(bill_id: bill_1.id, rep_name: representative.name, vote_with: 'Democrat')
          RepVotes.create(bill_id: bill_2.id, rep_name: representative.name, vote_with: 'Republican')

          expected = {bill_2.category => 1}
          expect(representative.anti_party_vote_categories).to eq(expected)
    end
  end
  end
end
