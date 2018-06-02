require 'rails_helper'

describe GeocodioService do
  context 'instance methods' do
    describe "district" do
      it "returns district for a given address" do
        VCR.use_cassette("find_district") do
          address = { street: '1271 S Marshall St',
                      city: 'Denver',
                      state: 'CO',
                      postal_code: '80232'
                    }

          expect(GeocodioService.new(address).district).to eq(7)
        end
      end
    end
  end
end
