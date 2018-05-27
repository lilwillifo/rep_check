require 'rails_helper'

describe PropublicaService do
  context 'instance methods' do
    describe "name" do
      it "finds member full name in state and district provided" do
        VCR.use_cassette("find_co_1_member") do
          raw_member = PropublicaService.find_house_member("CO", 1)

          expect(raw_member.first[:name]).to eq("Diana DeGette")
          expect(raw_member.first[:party]).to eq("D")
          expect(raw_member.first[:district]).to eq("1")
        end
      end
    end
  end
end
